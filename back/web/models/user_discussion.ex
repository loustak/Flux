defmodule Flux.UserDiscussion do
  use Flux.Web, :model

  schema "user_discussions" do
    belongs_to :user, Flux.User, foreign_key: :user_id
    belongs_to :discussion, Flux.Discussion, foreign_key: :discussion_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
