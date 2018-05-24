defmodule Flux.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string, null: false
      add :public, :boolean, default: false, null: false
      add :joinable, :boolean, default: true, null: false

      timestamps()
    end
  end
end