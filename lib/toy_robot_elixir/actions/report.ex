defmodule ToyRobotElixir.Actions.Report do
  @behaviour ToyRobotElixir.Actions.Action

  @impl true
  def execute(robot, _) do
    IO.puts(
      "#{IO.ANSI.magenta()}Output: #{robot.x},#{robot.y},#{format_face(robot.face)}#{IO.ANSI.reset()}"
    )

    robot
  end

  defp format_face(face) do
    face
    |> Atom.to_string()
    |> String.upcase()
  end

  @impl true
  def validate(nil, _, []), do: {:error, "Robot not placed"}
  def validate(_robot, _, []), do: :ok
end
