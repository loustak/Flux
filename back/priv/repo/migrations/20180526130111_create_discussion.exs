defmodule Flux.Repo.Migrations.CreateDiscussion do
  use Ecto.Migration

  def change do
    create table(:discussions) do
      add :community_id, references(:communities, on_delete: :delete_all), null: false
      add :name, :string, null: false

      timestamps()
    end

    create index(:discussions, [:community_id])
  end
end
