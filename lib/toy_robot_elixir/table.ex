defmodule ToyRobotElixir.Table do
  defstruct max_x: 5, max_y: 5, min_x: 0, min_y: 0

  @spec is_out_of_table?(integer(), integer(), %__MODULE__{}) :: boolean()
  def is_out_of_table?(x, y, table \\ %__MODULE__{}) do
    x < table.min_x or x >= table.max_x or y < table.min_y or y >= table.max_y
  end
end
