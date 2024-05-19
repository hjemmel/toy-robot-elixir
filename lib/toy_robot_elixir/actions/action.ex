defmodule ToyRobotElixir.Actions.Action do
  alias ToyRobotElixir.Table
  use GenServer

  @type args :: [any()] | []
  @type robot :: %ToyRobotElixir.Robot{face: atom(), x: non_neg_integer(), y: non_neg_integer()}
  @type table :: %Table{
          max_x: integer(),
          max_y: integer(),
          min_x: integer(),
          min_y: integer()
        }

  @callback execute(robot :: robot(), args :: args()) :: robot()
  @callback validate(robot :: robot(), table :: table(), args :: list()) ::
              :ok | {:error, String.t()}

  def start_link(_) do
    state = %{success: [], error: []}

    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @spec execute({module(), table(), args()}) :: {:ok, robot()} | {:error, String.t()}
  def execute(command) do
    GenServer.call(__MODULE__, {:execute, command})
  end

  @impl true
  def handle_call({:execute, {mod, table, args}}, _from, state) do
    current_robot = List.last(state.success)

    case mod.validate(current_robot, table, args) do
      :ok ->
        new_robot = mod.execute(current_robot, args)
        new_state = %{state | success: state.success ++ [new_robot]}

        {:reply, {:ok, new_robot}, new_state}

      {:error, reason} ->
        new_state = %{state | error: state.error ++ [reason]}
        {:reply, {:error, reason}, new_state}
    end
  end

  @impl true
  def handle_info(:clean, _state) do
    {:noreply, %{success: [], error: []}}
  end
end
