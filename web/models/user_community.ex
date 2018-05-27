defmodule Flux.UserCommunity do
  use Flux.Web, :model

  schema "user_communities" do
    belongs_to :user, Flux.User, foreign_key: :user_id
    belongs_to :community, Flux.Community, foreign_key: :community_id

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :community_id])
    |> validate_required([:user_id, :community_id])
    |> unique_constraint(:user_id_community_id)
  end
end
