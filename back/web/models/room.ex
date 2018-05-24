defmodule Flux.Room do
  use Flux.Web, :model

  schema "rooms" do
    field :name, :string
    field :public, :boolean, default: false
    field :joinable, :boolean, default: false
    field :joinable_invitation, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :public, :joinable, :joinable_invitation])
    |> validate_required([:name, :public, :joinable, :joinable_invitation])
  end
end
