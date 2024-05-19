defmodule ToyRobotElixir.CliTest do
  use ExUnit.Case

  alias ToyRobotElixir.{Cli, Robot}

  import ExUnit.CaptureIO

  describe "place/3" do
    test "return ok all arguments are valid" do
      assert Cli.place(3, 3, :north) == {:ok, %Robot{x: 3, y: 3, face: :north}}
    end

    test "return ok when face is string" do
      assert Cli.place(3, 3, "north") == {:ok, %Robot{x: 3, y: 3, face: :north}}
    end

    test "returns error face is wrong" do
      assert Cli.place(-1, 3, "invalid") == {:error, "Face invalid is not valid"}
    end

    test "returns error when x is out of the table" do
      assert Cli.place(5, 3, :north) == {:error, "Coordenates out of the table"}
    end

    test "returns error when y is out of the table" do
      assert Cli.place(3, 5, :north) == {:error, "Coordenates out of the table"}
    end

    test "returns error all arguments not passed" do
      assert Cli.place() == {:error, "Missing arguments"}
    end
  end

  describe "move/0" do
    setup :clean_server

    test "returns position for a robot" do
      Cli.place(2, 2, :north)

      assert Cli.move() == {:ok, %Robot{x: 2, y: 3, face: :north}}
    end

    test "returns error when robot is nil" do
      assert Cli.move() == {:error, "Robot not placed"}
    end

    test "returns error when x is out of the table" do
      Cli.place(4, 0, :east)

      assert Cli.move() == {:error, "Coordenates out of the table"}
    end

    test "returns error when y is out of the table" do
      Cli.place(0, 4, :north)

      assert Cli.move() == {:error, "Coordenates out of the table"}
    end
  end

  describe "left/0" do
    setup :clean_server

    test "returns position for a robot" do
      Cli.place(2, 2, :north)

      assert Cli.left() == {:ok, %Robot{x: 2, y: 2, face: :west}}
      assert Cli.left() == {:ok, %Robot{x: 2, y: 2, face: :south}}
      assert Cli.left() == {:ok, %Robot{x: 2, y: 2, face: :east}}
      assert Cli.left() == {:ok, %Robot{x: 2, y: 2, face: :north}}
    end

    test "returns error when robot is nil" do
      assert Cli.left() == {:error, "Robot not placed"}
    end
  end

  describe "right/0" do
    setup :clean_server

    test "returns position for a robot" do
      Cli.place(2, 2, :north)

      assert Cli.right() == {:ok, %Robot{x: 2, y: 2, face: :east}}
      assert Cli.right() == {:ok, %Robot{x: 2, y: 2, face: :south}}
      assert Cli.right() == {:ok, %Robot{x: 2, y: 2, face: :west}}
      assert Cli.right() == {:ok, %Robot{x: 2, y: 2, face: :north}}
    end

    test "returns error when robot is nil" do
      assert Cli.right() == {:error, "Robot not placed"}
    end
  end

  describe "report/0" do
    setup :clean_server

    test "returns position for a robot" do
      Cli.place(2, 2, :north)

      assert Cli.report() == {:ok, %Robot{x: 2, y: 2, face: :north}}
    end

    test "returns error when robot is nil" do
      assert Cli.report() == {:error, "Robot not placed"}
    end
  end

  describe "welcome/0" do
    test "returns welcome message" do
      msg = capture_io(&Cli.welcome/0)
      assert msg =~ "Welcome to Toy Robot Elixir"
      assert msg =~ "Commands:"
      assert msg =~ "place x, y, face"
      assert msg =~ "move"
      assert msg =~ "left"
      assert msg =~ "right"
      assert msg =~ "report"
    end
  end

  describe "examples" do
    setup :clean_server

    test "example 1" do
      Cli.place(0, 0, :north)
      Cli.move()
      assert Cli.report() == {:ok, %Robot{x: 0, y: 1, face: :north}}
    end

    test "example 2" do
      Cli.place(0, 0, :north)
      Cli.left()
      assert Cli.report() == {:ok, %Robot{x: 0, y: 0, face: :west}}
    end

    test "example 3" do
      Cli.place(1, 2, :east)
      Cli.move()
      Cli.move()
      Cli.left()
      Cli.move()
      assert Cli.report() == {:ok, %Robot{x: 3, y: 3, face: :north}}
    end
  end

  defp clean_server(_) do
    pid = Process.whereis(ToyRobotElixir.Actions.Action)
    send(pid, :clean)
    :ok
  end
end
