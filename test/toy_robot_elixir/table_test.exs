defmodule ToyRobotElixir.TableTest do
  use ExUnit.Case

  alias ToyRobotElixir.Table

  describe "is_out_of_table?/3" do
    test "returns false when x and y are inside the table" do
      assert Table.is_out_of_table?(0, 0) == false
      assert Table.is_out_of_table?(4, 4) == false
    end

    test "returns true when x and/or y are outside the table" do
      assert Table.is_out_of_table?(5, 5) == true
      assert Table.is_out_of_table?(-1, -1) == true
      assert Table.is_out_of_table?(5, 0) == true
      assert Table.is_out_of_table?(-1, 0) == true
      assert Table.is_out_of_table?(0, 5) == true
      assert Table.is_out_of_table?(0, -1) == true
    end

    test "returns correct calculation if new table is used" do
      table = %Table{max_x: 3, max_y: 3, min_x: 1, min_y: 1}
      assert Table.is_out_of_table?(2, 2, table) == false
      assert Table.is_out_of_table?(1, 1, table) == false

      assert Table.is_out_of_table?(3, 3, table) == true
      assert Table.is_out_of_table?(0, 0, table) == true
    end
  end
end
