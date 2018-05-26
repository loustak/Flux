defmodule Flux.UserDiscussion do
  use Flux.Web, :model

  schema "user_discussions" do
    belongs_to :user, Flux.User, foreign_key: :user_id
    belongs_to :discussion, Flux.Discussion, foreign_key: :discussion_id

    many_to_many :users, Flux.User, join_through: "user_discussions"

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :discussion_id])
    |> validate_required([:user_id, :discussion_id])
    |> unique_constraint(:user_id_discussion_id)
  end
end
