defmodule Py do
  use GenServer

  @code_head """
  from scipy import stats

  """

  # Start the GenServer
  def start_link do
    GenServer.start_link(__MODULE__, %{globals: %{}}, name: __MODULE__)
  end

  # Compute the quantile of a normal distribution
  def norm_ppf(q, loc \\ 0, scale \\ 1) do
    GenServer.call(
      __MODULE__,
      {:ppf, "stats.norm.ppf(q, loc, scale)", %{"loc" => loc, "scale" => scale, "q" => q}}
    )
  end

  # Compute the quantile of a Student-t distributio n
  def t_ppf(q, dof \\ 1) do
    GenServer.call(
      __MODULE__,
      {:ppf, "stats.t.ppf(q, dof)", %{"dof" => dof, "q" => q}}
    )
  end

  # Callback functions
  @impl true
  def init(init_arg) do
    {:ok, init_arg}
  end

  @impl true
  def handle_call({:ppf, code, params}, _from, state) do
    # Python code to be executed
    code =
      """
      #{@code_head}

      #{code}
      """

    # Evaluate the code via Python code
    {res, _globals} = Pythonx.eval(code, params)

    # Reply to the caller with the decoded output
    {:reply, Pythonx.decode(res), state}
  end
end
