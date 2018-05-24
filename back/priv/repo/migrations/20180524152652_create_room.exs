defmodule Flux.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :public, :boolean, default: false, null: false
      add :joinable, :boolean, default: false, null: false
      add :joinable_invitation, :boolean, default: false, null: false

      timestamps()
    end
  end
end
