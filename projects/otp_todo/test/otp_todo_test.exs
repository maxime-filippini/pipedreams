defmodule OtpTodoTest do
  use ExUnit.Case
  doctest OtpTodo

  test "greets the world" do
    assert OtpTodo.hello() == :world
  end
end
