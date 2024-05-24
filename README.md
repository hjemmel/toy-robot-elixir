# ToyRobot Elixir

Toy robot application based on the problem statement in (PROBLEM.md)[PROBLEM.md]

## How to Run the application and the tests

### Requirements

- [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

## Running

### Run the tests

```sh
make test
```

### Run the application

```sh
make dev
```

### Running with docker directly

```sh
docker run --rm -it $(docker build -q .) iex -S mix
```

or for tests

```sh
docker run --rm -it $(docker build -q .) mix test --trace
```

## How to use the application

just type the commands in the terminal, like the example below:

```plain
iex> place 0,0,"north"
iex> left
iex> report
iex> Output: 0,0,WEST
```

## Notes

- Commands must be in lowercase.
- Face might be a atom (like symbols in ruby) or string.
  - Example: `:north` or `"north"` are valid.
- The application raise an error for commands that are not valid.
  - Example: `place 0,0,north` is valid, but `report all` is not valid, so `undefined function` error will be raised.

## Implementation Details

- `cli.ex` is the entry point of the application.
- `table.ex` is the module that represents the table.
- `action.ex` defines the behavior (interface) to be implemented by the actions.
  - Each command is a module that implements the `Action` behavior.
  - `action.ex` is also a elixir GenServer that receives the commands, call the respective module and store a stack of successful commands and errors.
  - Each command module is responsible to validate the command and return the new state of the robot.
