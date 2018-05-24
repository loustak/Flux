defmodule Flux.Room do
  use Flux.Web, :model

  schema "rooms" do
    field :name, :string, null: false
    field :public, :boolean, default: false, null: false
    field :joinable, :boolean, default: true, null: false

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :public, :joinable])
    |> validate_required([:name, :public, :joinable])
    |> validate_length(:name, min: 3, max: 24)
  end
end
