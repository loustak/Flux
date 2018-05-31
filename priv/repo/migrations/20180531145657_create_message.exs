defmodule Flux.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :discussion_id, references(:discussions, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :text, :string

      timestamps()
    end

    create index(:messages, [:discussion_id])
    create index(:messages, [:user_id])
  end
end
