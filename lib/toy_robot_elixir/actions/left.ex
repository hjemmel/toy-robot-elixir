defmodule ToyRobotElixir.Actions.Left do
  @behaviour ToyRobotElixir.Actions.Action

  @impl true
  def execute(robot, _) do
    %ToyRobotElixir.Robot{robot | face: left(robot.face)}
  end

  @impl true
  def validate(nil, _, []), do: {:error, "Robot not placed"}
  def validate(_robot, _, []), do: :ok

  defp left(:north), do: :west
  defp left(:west), do: :south
  defp left(:south), do: :east
  defp left(:east), do: :north
end
