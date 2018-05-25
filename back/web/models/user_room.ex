defmodule Flux.UserRoom do
  use Flux.Web, :model

  schema "user_rooms" do
    belongs_to :user, Flux.User, foreign_key: :user_id
    belongs_to :room, Flux.Room, foreign_key: :room_id

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :room_id])
    |> validate_required([:user_id, :room_id])
    |> unique_constraint(:user_id_room_id)
  end
end
