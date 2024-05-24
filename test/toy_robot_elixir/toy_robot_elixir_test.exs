defmodule ToyRobotElixirTest do
  use ExUnit.Case
  doctest ToyRobotElixir

  test "greets the world" do
    assert ToyRobotElixir.hello() == :world
  end
end
