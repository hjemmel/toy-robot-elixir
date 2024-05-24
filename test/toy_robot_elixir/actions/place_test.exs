defmodule ToyRobotElixir.Actions.PlaceTest do
  use ExUnit.Case
  alias ToyRobotElixir.{Actions.Place, Robot, Table}

  describe "validate/3" do
    setup do
      [table: %Table{}]
    end

    test "return ok all arguments are valid", %{table: table} do
      assert Place.validate(nil, table, [2, 2, :north]) == :ok
    end

    test "returns error when x is not an valid argument", %{table: table} do
      assert Place.validate(nil, table, ["0", 0, :north]) == {:error, "Missing arguments"}
    end

    test "returns error when y is not an valid argument", %{table: table} do
      assert Place.validate(nil, table, [0, "0", :north]) == {:error, "Missing arguments"}
    end

    test "returns error when face is nil", %{table: table} do
      assert Place.validate(nil, table, [0, 0, nil]) == {:error, "Missing facing argument"}
    end

    test "returns error when x is out of the table", %{table: table} do
      assert Place.validate(nil, table, [5, 0, :north]) ==
               {:error, "Coordenates out of the table"}
    end

    test "returns error when y is out of the table", %{table: table} do
      assert Place.validate(nil, table, [0, 5, :north]) ==
               {:error, "Coordenates out of the table"}
    end

    test "returns error when face is invalid", %{table: table} do
      assert Place.validate(nil, table, [2, 2, :non_valid]) ==
               {:error, "Face non_valid is not valid"}
    end

    test "returns error when invalid args" do
      assert Place.validate(nil, nil, [3, 0, :north]) == {:error, "Missing arguments"}
    end
  end

  describe "execute/2" do
    test "returns position for a robot" do
      robot = %Robot{x: 4, y: 4, face: :west}

      assert Place.execute(robot, [2, 2, :north]) == %Robot{x: 2, y: 2, face: :north}
    end

    test "returns place a brand new robot when no robot is passed" do
      assert Place.execute(nil, [0, 0, :north]) == %Robot{x: 0, y: 0, face: :north}
    end
  end
end
