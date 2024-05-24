defmodule ToyRobotElixir.Actions.Move do
  @behaviour ToyRobotElixir.Actions.Action

  alias ToyRobotElixir.{Robot, Table}

  @impl true
  def execute(robot, _) do
    %Robot{robot | x: new_x(robot), y: new_y(robot)}
  end

  @impl true
  def validate(nil, _, []), do: {:error, "Robot not placed"}

  def validate(robot, %Table{} = table, []) do
    if Table.is_out_of_table?(new_x(robot), new_y(robot), table) do
      {:error, "Coordenates out of the table"}
    else
      :ok
    end
  end

  def validate(_, _, _), do: {:error, "Missing arguments"}

  defp new_x(%ToyRobotElixir.Robot{x: x, face: :north}), do: x
  defp new_x(%ToyRobotElixir.Robot{x: x, face: :south}), do: x
  defp new_x(%ToyRobotElixir.Robot{x: x, face: :east}), do: x + 1
  defp new_x(%ToyRobotElixir.Robot{x: x, face: :west}), do: x - 1

  defp new_y(%ToyRobotElixir.Robot{y: y, face: :east}), do: y
  defp new_y(%ToyRobotElixir.Robot{y: y, face: :west}), do: y
  defp new_y(%ToyRobotElixir.Robot{y: y, face: :north}), do: y + 1
  defp new_y(%ToyRobotElixir.Robot{y: y, face: :south}), do: y - 1
end
