defmodule Flux.UserDiscussionController do
  use Flux.Web, :controller

  alias Flux.UserDiscussion
  alias Flux.UserDiscussionView

  defp insert(conn, changeset) do
    case Repo.insert(changeset) do
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Flux.ChangesetView, "error.json", changeset: changeset)
      _ -> {:ok, changeset}
    end
  end

  def create(conn, %{"id" => discussion_id}) do
    %{id: user_id} = Flux.Guardian.Plug.current_resource(conn)
    changeset = UserDiscussion.changeset(%UserDiscussion{}, %{user_id: user_id, discussion_id: discussion_id})

    with {:ok, discussion} <- Flux.DiscussionController.discussion_exists(conn, discussion_id),
         {:ok, _} <- Flux.UserCommunityController.user_community_exists(conn, user_id, discussion.community_id), 
         {:ok, _} <- insert(conn, changeset), do:
      conn
      |> put_status(:created)
      |> render(UserDiscussionView, "create.json", discussion: discussion)
  end

  def delete(conn, %{"id" => discussion_id}) do
    %{id: user_id} = Flux.Guardian.Plug.current_resource(conn)

    with {:ok, user_discussion} <- user_discussion_exists(conn, user_id, discussion_id), do:
      Repo.delete(user_discussion)
      conn
      |> put_status(:ok)
      |> render(UserDiscussionView, "delete.json")
  end

  def user_discussion_exists(conn, user_id, discussion_id) do
    user_discussion = Repo.get_by(UserDiscussion, %{user_id: user_id, discussion_id: discussion_id})
    case user_discussion do
      nil -> 
        conn
        |> put_status(:not_found)
        |> render(UserDiscussionView, "not_found.json")
      _ -> {:ok, user_discussion}
    end
  end
end
