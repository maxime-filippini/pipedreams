defmodule ExplorerTestingTest do
  use ExUnit.Case
  doctest ExplorerTesting

  test "greets the world" do
    assert ExplorerTesting.hello() == :world
  end
end
