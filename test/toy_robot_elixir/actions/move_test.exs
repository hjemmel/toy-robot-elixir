defmodule ToyRobotElixir.Actions.MoveTest do
  use ExUnit.Case
  alias ToyRobotElixir.{Actions.Move, Robot, Table}

  describe "validate/3" do
    setup do
      [table: %Table{}]
    end

    test "return ok all arguments are valid", %{table: table} do
      assert Move.validate(%Robot{x: 0, y: 0, face: :north}, table, []) == :ok
    end

    test "returns error when robot is nil", %{table: table} do
      assert Move.validate(nil, table, []) == {:error, "Robot not placed"}
    end

    test "returns error when x is out of the table", %{table: table} do
      assert Move.validate(%Robot{x: 4, y: 0, face: :east}, table, []) ==
               {:error, "Coordenates out of the table"}

      assert Move.validate(%Robot{x: 0, y: 0, face: :west}, table, []) ==
               {:error, "Coordenates out of the table"}
    end

    test "returns error when y is out of the table", %{table: table} do
      assert Move.validate(%Robot{x: 0, y: 4, face: :north}, table, []) ==
               {:error, "Coordenates out of the table"}

      assert Move.validate(%Robot{x: 0, y: 0, face: :south}, table, []) ==
               {:error, "Coordenates out of the table"}
    end

    test "returns error when invalid args" do
      assert Move.validate(%Robot{}, nil, []) == {:error, "Missing arguments"}
    end
  end

  describe "execute/2" do
    test "returns position for a robot" do
      robot = %Robot{x: 2, y: 2, face: :north}

      assert Move.execute(robot, %Table{}) == %Robot{x: 2, y: 3, face: :north}
      assert Move.execute(%{robot | face: :south}, %Table{}) == %Robot{x: 2, y: 1, face: :south}
      assert Move.execute(%{robot | face: :west}, %Table{}) == %Robot{x: 1, y: 2, face: :west}
      assert Move.execute(%{robot | face: :east}, %Table{}) == %Robot{x: 3, y: 2, face: :east}
    end
  end
end
