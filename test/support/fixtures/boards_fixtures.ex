defmodule Ajedrez.BoardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ajedrez.Boards` context.
  """

  @doc """
  Generate a unique position name.
  """
  def unique_position_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a position.
  """
  def position_fixture(_attrs \\ %{}) do
    Ajedrez.Boards.set_fen(unique_position_name(), "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR")
  end
end
