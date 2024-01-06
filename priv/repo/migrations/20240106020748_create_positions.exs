defmodule Ajedrez.Repo.Migrations.CreatePositions do
  use Ecto.Migration

  def change do
    create table(:positions) do
      add :name, :string
      add :fen, :string

      timestamps()
    end

    create unique_index(:positions, [:name])
  end
end
