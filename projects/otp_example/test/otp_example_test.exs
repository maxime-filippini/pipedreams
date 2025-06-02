defmodule OtpExampleTest do
  use ExUnit.Case
  doctest OtpExample

  test "greets the world" do
    assert OtpExample.hello() == :world
  end
end
