defmodule Flux.Repo.Migrations.CreateCommunity do
  use Ecto.Migration

  def change do
    create table(:communities) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :name, :string, null: false
      add :public, :boolean, default: false, null: false
      add :joinable, :boolean, default: true, null: false

      timestamps()
    end

    create index(:communities, [:user_id])
  end
end