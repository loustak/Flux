defmodule Flux.Message do
  use Flux.Web, :model

  schema "messages" do
    field :text, :string
    belongs_to :discussion, Flux.Discussion, foreign_key: :discussion_id
    belongs_to :user, Flux.User, foreign_key: :user_id

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:discussion_id, :user_id, :text])
    |> validate_required([:discussion_id, :user_id, :text])
  end
end
