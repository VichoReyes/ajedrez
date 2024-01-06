defmodule Ajedrez.BoardsTest do
  use Ajedrez.DataCase

  alias Ajedrez.Boards

  describe "positions" do
    alias Ajedrez.Boards.Position

    import Ajedrez.BoardsFixtures

    test "set_fen/2 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Boards.set_fen("valid_name", "invalid_fen")
    end

    test "set_fen/2 with valid data updates the position" do
      {:ok, position} = position_fixture()
      new_fen = "8/8/8/8/8/8/8/8"

      assert {:ok, %Position{} = position} = Boards.set_fen(position.name, new_fen)
      assert position.fen == new_fen
      assert "8/8/8/8/8/8/8/8" == Boards.get_fen(position.name)
    end
  end
end
