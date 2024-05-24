defmodule ToyRobotElixir.Actions.RightTest do
  use ExUnit.Case
  alias ToyRobotElixir.{Actions.Right, Robot, Table}

  describe "validate/3" do
    setup do
      [table: %Table{}]
    end

    test "return ok all arguments are valid", %{table: table} do
      assert Right.validate(%Robot{x: 0, y: 0, face: :north}, table, []) == :ok
    end

    test "returns error when robot is nil", %{table: table} do
      assert Right.validate(nil, table, []) == {:error, "Robot not placed"}
    end
  end

  describe "execute/2" do
    test "returns position for a robot" do
      robot = %Robot{x: 2, y: 2, face: :north}

      assert Right.execute(robot, %Table{}) == %Robot{x: 2, y: 2, face: :east}
      assert Right.execute(%{robot | face: :east}, %Table{}) == %Robot{x: 2, y: 2, face: :south}
      assert Right.execute(%{robot | face: :south}, %Table{}) == %Robot{x: 2, y: 2, face: :west}
      assert Right.execute(%{robot | face: :west}, %Table{}) == %Robot{x: 2, y: 2, face: :north}
    end
  end
end
