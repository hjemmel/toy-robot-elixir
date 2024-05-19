defmodule ToyRobotElixir.Actions.Right do
  @behaviour ToyRobotElixir.Actions.Action

  @impl true
  def execute(robot, _) do
    %ToyRobotElixir.Robot{robot | face: right(robot.face)}
  end

  @impl true
  def validate(nil, _, []), do: {:error, "Robot not placed"}
  def validate(_robot, _, []), do: :ok

  defp right(:north), do: :east
  defp right(:east), do: :south
  defp right(:south), do: :west
  defp right(:west), do: :north
end
