defmodule FridgeBuddy do
  use GenServer
  alias Llm.OpenAiClient
  alias Llm.Chat

  # Client
  def start_link() do
    GenServer.start_link(__MODULE__, %{ingredients: [], preferences: []}, name: __MODULE__)
  end

  def add_ingredient(name, quantity) do
    GenServer.cast(__MODULE__, {:add_ingredient, %{name: name, quantity: quantity}})
  end

  def get_ingredients() do
    GenServer.call(__MODULE__, :get_ingredients)
  end

  def aggregate_ingredients() do
    collected =
      get_ingredients()
      |> Enum.reduce(%{}, fn ing, acc ->
        Map.update(acc, ing.name, [ing.quantity], fn v -> [ing.quantity | v] end)
      end)

    # Build a chat
    Chat.new()
    |> Chat.add_message("system", """
    You are a unit calculator. You will be provided with a JSON object with keys
    that represent ingredients, and values that hold lists of quantities. These
    quantities might be in different units. Upon receiving this object, you will
    take all of the quantities associated with each ingredient, and sum them
    all into a single quantity, expressed in the reference unit.

    - For liquids, use milliliters as a reference unit.
    - Treat yogurts and dairy as liquids.
    - For all other ingredients, use grams.

    Respond using JSON, in the same format as the input. Do not include any
    other output in your response!

    For example:

    {{"apple": [1, "100g"], "milk": ["1L", "300g"]}}

    should yield:

    {{"apple": "250g", "milk": "1300mL"}}

    since one apple weighs roughly 150g, and milk has a density of 1kg per
    liter. Use your best averages for these conversions.
    """)
    |> Chat.add_message("user", JSON.encode!(collected))
    |> OpenAiClient.send()
  end

  # Callback
  @impl true
  def init(arg) do
    {:ok, arg}
  end

  @impl true
  def handle_cast({:add_ingredient, ingredient}, state) do
    new_state = %{state | ingredients: [ingredient | state.ingredients]}
    {:noreply, new_state}
  end

  @impl true
  def handle_call(:get_ingredients, _from, state) do
    {:reply, state.ingredients, state}
  end
end
