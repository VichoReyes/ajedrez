defmodule Ajedrez.Boards do
  @moduledoc """
  The Boards context.
  """

  import Ecto.Query, warn: false
  alias Ajedrez.Repo

  alias Ajedrez.Boards.Position

  @doc """
  Gets the position from a game name.

  ## Examples

      iex> get_fen("ruy_lopez")
      "r1bqkbnr/pppp1ppp/2n5/1B2p3/4P3/5N2/PPPP1PPP/RNBQK2R"

      iex> get_fen("non_existant_game")
      "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"

  """
  def get_fen(name) do
    # pattern match on Repo.get(Position, id)
    case Repo.get_by(Position, [name: name]) do
      %Position{fen: fen} -> fen
      nil -> "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"
    end
  end

  @doc """
  Sets the current position for a game.
  Can either create a new position or update an existing one.
  Will return the Position struct either way

  ## Examples

      iex> set_fen("ruy_lopez", "r1bqkbnr/pppp1ppp/2n5/1B2p3/4P3/5N2/PPPP1PPP/RNBQK2R")
      {:ok, %Ajedrez.Boards.Position{...}}

      iex> set_fen("ruy_lopez", "invalid_fen")
      {:error, %Ecto.Changeset{...}}
  """
  def set_fen(name, fen) do
    position = %Position{}
    changeset = Position.changeset(position, %{name: name, fen: fen})

    Repo.insert(changeset, on_conflict: [set: [fen: fen]], conflict_target: [:name])
  end

  @doc """
  Deletes all Position records that haven't been updated in a given amount of time, which is given in seconds
  """
  def cleanup(stale_time) when is_integer(stale_time) do
    from(p in Position, where: p.updated_at < ^DateTime.add(DateTime.utc_now(), -stale_time, :second))
    |> Repo.delete_all()
  end
end
