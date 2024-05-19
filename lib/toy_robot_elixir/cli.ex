defmodule ToyRobotElixir.Cli do
  alias ToyRobotElixir.Robot
  alias ToyRobotElixir.Table
  alias ToyRobotElixir.Actions.Action

  def welcome do
    IO.puts(
      "#{IO.ANSI.blue()}  #{IO.ANSI.magenta()}   Welcome to Toy Robot Elixir   #{IO.ANSI.blue()}  #{IO.ANSI.reset()}\n"
    )

    IO.puts("#{IO.ANSI.magenta()}Commands: #{IO.ANSI.blue()}")
    IO.puts(" place x, y, face")
    IO.puts(" move")
    IO.puts(" left")
    IO.puts(" right")
    IO.puts(" report #{IO.ANSI.reset()}")
  end

  @spec place(x :: integer() | nil, y :: integer() | nil, face :: String.t() | atom() | nil) ::
          {:ok, %Robot{}} | {:error, String.t()}
  def place(x \\ nil, y \\ nil, face \\ nil)

  @spec place(x :: integer(), y :: integer(), face :: String.t()) ::
          {:ok, %Robot{}} | {:error, String.t()}
  def place(x, y, face) when is_binary(face) do
    place(x, y, face |> String.downcase() |> String.to_atom())
  end

  @spec place(x :: integer(), y :: integer(), face :: atom()) ::
          {:ok, %Robot{}} | {:error, String.t()}
  def place(x, y, face) do
    Action.execute({ToyRobotElixir.Actions.Place, get_table(), [x, y, face]})
  end

  @spec move() :: {:ok, %Robot{}} | {:error, String.t()}
  def move do
    Action.execute({ToyRobotElixir.Actions.Move, get_table(), []})
  end

  @spec left() :: {:ok, %Robot{}} | {:error, String.t()}
  def left do
    Action.execute({ToyRobotElixir.Actions.Left, get_table(), []})
  end

  @spec right() :: {:ok, %Robot{}} | {:error, String.t()}
  def right do
    Action.execute({ToyRobotElixir.Actions.Right, get_table(), []})
  end

  @spec report() :: {:ok, %Robot{}} | {:error, String.t()}
  def report do
    Action.execute({ToyRobotElixir.Actions.Report, get_table(), []})
  end

  defp get_table do
    %Table{}
  end
end
