defmodule Flux.Repo.Migrations.CreateUserDiscussion do
  use Ecto.Migration

  def change do
    create table(:user_discussions) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :discussion_id, references(:discussions, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:user_discussions, [:user_id])
    create index(:user_discussions, [:discussion_id])
    create index(:user_discussions, [:user_id, :discussion_id], unique: true)
  end
end
