defmodule FridgeBuddyTest do
  use ExUnit.Case
  doctest FridgeBuddy

  test "greets the world" do
    assert FridgeBuddy.hello() == :world
  end
end
