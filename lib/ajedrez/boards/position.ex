defmodule Ajedrez.Boards.Position do
  use Ecto.Schema
  import Ecto.Changeset

  schema "positions" do
    field :name, :string
    field :fen, :string

    timestamps()
  end

  @doc false
  def changeset(position, attrs) do
    position
    |> cast(attrs, [:name, :fen])
    |> validate_required([:name, :fen])
    |> validate_change(:fen, &validate_fen/2)
    |> unique_constraint(:name)
  end

  defp validate_fen(:fen, fen) do
    rows = String.split(fen, "/")
    if Enum.count(rows) != 8, do: [fen: "FEN should have 8 rows"]

    Enum.reduce_while(rows, [], fn row, _acc ->
      case validate_row(row) do
        [] -> {:cont, []}
        error -> {:halt, error}
      end
    end)
  end

  defp validate_row(row, taken \\ 0, last_was_number \\ false)
  defp validate_row("", 8, _), do: []
  defp validate_row("", _taken, _), do: [fen: "Row is too short"]
  defp validate_row(_, taken, _) when taken > 8, do: [fen: "Row is too long"]

  defp validate_row(<<first_letter::binary-size(1), rest::binary>>, taken, last_was_number) do
    cond do
      String.match?(first_letter, ~r/[kqrnbp]/i) ->
        validate_row(rest, taken + 1, false)

      String.match?(first_letter, ~r/[1-8]/) and last_was_number ->
        [fen: "Two numbers in a row"]

      String.match?(first_letter, ~r/[1-8]/) ->
        validate_row(rest, taken + String.to_integer(first_letter), true)

      true ->
        [fen: "Invalid character"]
    end
  end

end
