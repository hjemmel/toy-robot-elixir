defmodule ToyRobotElixir.Actions.ReportTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ToyRobotElixir.{Actions.Report, Robot, Table}

  describe "validate/3" do
    setup do
      [table: %Table{}]
    end

    test "return ok all arguments are valid", %{table: table} do
      assert Report.validate(%Robot{x: 0, y: 0, face: :north}, table, []) == :ok
    end

    test "returns error when robot is nil", %{table: table} do
      assert Report.validate(nil, table, []) == {:error, "Robot not placed"}
    end
  end

  describe "excute/2" do
    test "returns position for a robot" do
      robot = %Robot{x: 2, y: 2, face: :north}

      assert capture_io(fn -> Report.execute(robot, %Table{}) end) =~ "Output: 2,2,NORTH"
    end
  end
end
