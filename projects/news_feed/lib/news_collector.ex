defmodule NewsCollector do
  use GenServer

  # Client
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{articles: []}, name: __MODULE__)
  end

  def get_state() do
    GenServer.call(__MODULE__, :state)
  end

  def add_article(url, headline) do
    GenServer.cast(__MODULE__, {:add_article, %{headline: headline, url: url}})
  end

  # Callbacks
  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:add_article, article}, state) do
    {:noreply, %{state | articles: [article | state.articles]}}
  end
end
