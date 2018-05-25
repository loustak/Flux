defmodule Flux.Repo.Migrations.CreateUserRoom do
  use Ecto.Migration

  def change do
    create table(:user_rooms, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true, null: false
      add :room_id, references(:rooms, on_delete: :delete_all), primary_key: true, null: false

      timestamps()
    end

    create index(:user_rooms, [:user_id])
    create index(:user_rooms, [:room_id])
    create index(:user_rooms, [:user_id, :room_id], unique: true)
  end
end
