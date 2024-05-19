defmodule ToyRobotElixir.Actions.Place do
  @behaviour ToyRobotElixir.Actions.Action

  alias ToyRobotElixir.{Robot, Table}

  @faces [:west, :south, :east, :north]

  @impl true
  def execute(nil, args) do
    execute(%Robot{}, args)
  end

  def execute(robot, [x, y, face]) do
    %Robot{robot | x: x, y: y, face: face}
  end

  @impl true
  def validate(_, _, [nil, nil, nil]),
    do: {:error, "Missing arguments"}

  def validate(_, _, [_, _, nil]),
    do: {:error, "Missing facing argument"}

  def validate(_, _, [_, _, face]) when face not in @faces,
    do: {:error, "Face #{face} is not valid"}

  def validate(_robot, %Table{} = table, [x, y, _])
      when is_integer(x) and is_integer(y) do
    if Table.is_out_of_table?(x, y, table) do
      {:error, "Coordenates out of the table"}
    else
      :ok
    end
  end

  def validate(_, _, _), do: {:error, "Missing arguments"}
end
