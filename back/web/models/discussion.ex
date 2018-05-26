defmodule Flux.Discussion do
  use Flux.Web, :model

  schema "discussions" do
    field :name, :string, null: false
    many_to_many :users, Flux.User, join_through: "user_discussions"

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 1, max: 24)
  end
end
