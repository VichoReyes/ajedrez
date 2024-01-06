defmodule Ajedrez.PositionStore do
  @moduledoc """
  PositionStore is responsible for storing and retrieving chess positions, stored as FEN codes.
  """
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    # initial position
    {:ok, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"}
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  def set(position) do
    validate_position(position)
    GenServer.call(__MODULE__, {:set, position})
  end

  defp validate_position(position) do
    rows = String.split(position, "/")
    8 = Enum.count(rows)
    Enum.each(rows, &validate_row/1)
  end

  defp validate_row(row, taken \\ 0, last_was_number \\ false)
  defp validate_row("", 8, _), do: :ok
  defp validate_row("", _taken, _), do: raise("Row is too short")
  defp validate_row(_, taken, _) when taken > 8, do: raise("Row is too long")

  defp validate_row(<<first_letter::binary-size(1), rest::binary>>, taken, last_was_number) do
    cond do
      String.match?(first_letter, ~r/[kqrnbp]/i) ->
        validate_row(rest, taken + 1, false)

      String.match?(first_letter, ~r/[1-8]/) and last_was_number ->
        raise "Two numbers in a row"

      String.match?(first_letter, ~r/[1-8]/) ->
        validate_row(rest, taken + String.to_integer(first_letter), true)

      true ->
        raise "Invalid character"
    end
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:set, position}, _from, _state) do
    {:reply, :ok, position}
  end
end
