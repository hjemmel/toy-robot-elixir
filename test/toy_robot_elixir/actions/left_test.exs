defmodule ToyRobotElixir.Actions.LeftTest do
  use ExUnit.Case

  alias ToyRobotElixir.{Actions.Left, Robot, Table}

  describe "validate/3" do
    setup do
      [table: %Table{}]
    end

    test "return ok all arguments are valid", %{table: table} do
      assert Left.validate(%Robot{x: 0, y: 0, face: :north}, table, []) == :ok
    end

    test "returns error when robot is nil", %{table: table} do
      assert Left.validate(nil, table, []) == {:error, "Robot not placed"}
    end
  end

  describe "execute/2" do
    test "returns position for a robot" do
      robot = %Robot{x: 2, y: 2, face: :north}

      assert Left.execute(robot, %Table{}) == %Robot{x: 2, y: 2, face: :west}
      assert Left.execute(%{robot | face: :west}, %Table{}) == %Robot{x: 2, y: 2, face: :south}
      assert Left.execute(%{robot | face: :south}, %Table{}) == %Robot{x: 2, y: 2, face: :east}
      assert Left.execute(%{robot | face: :east}, %Table{}) == %Robot{x: 2, y: 2, face: :north}
    end
  end
end
