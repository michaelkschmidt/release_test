defmodule ReleaseTestTest do
  use ExUnit.Case
  doctest ReleaseTest

  test "greets the world" do
    assert ReleaseTest.hello() == :world
  end
end
