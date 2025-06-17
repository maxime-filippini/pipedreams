defmodule Agents.Greeter do
  use GenServer

  # Callback functions

  # Client functions
  def start_link(name) do
    GenServer.start_link(__MODULE__, %{})
  end
end
