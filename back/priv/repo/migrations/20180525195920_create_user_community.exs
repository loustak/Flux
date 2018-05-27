defmodule Flux.Repo.Migrations.CreateUserCommunity do
  use Ecto.Migration

  def change do
    create table(:user_communities) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :community_id, references(:communities, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:user_communities, [:user_id])
    create index(:user_communities, [:community_id])
    create index(:user_communities, [:user_id, :community_id], unique: true)
  end
end
