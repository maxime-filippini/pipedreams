defmodule NewsFeedTest do
  use ExUnit.Case
  doctest NewsFeed

  test "greets the world" do
    assert NewsFeed.hello() == :world
  end
end
