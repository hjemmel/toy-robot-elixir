defmodule ToyRobotElixir.RobotTest do
  use ExUnit.Case

  alias ToyRobotElixir.Robot

  test "returns a empty struct " do
    assert %Robot{x: nil, y: nil, face: nil} == %Robot{}
  end

  test "returns a populated struct " do
    assert %Robot{x: 0, y: 5, face: "NORTH"} == %Robot{x: 0, y: 5, face: "NORTH"}
  end
end
