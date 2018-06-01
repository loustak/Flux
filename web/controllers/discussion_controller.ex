defmodule Flux.DiscussionController do
  use Flux.Web, :controller

  alias Flux.Discussion
  alias Flux.DiscussionView

  def insert(conn, changeset) do
    case Repo.insert(changeset) do
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Flux.ChangesetView, "error.json", changeset: changeset)
      _ -> {:ok, changeset}
    end
  end

  def create(conn, %{"community_id" => community_id} = params) do
    changeset = Discussion.changeset(%Discussion{}, params)
    
    with {:ok, discussion} <- Flux.CommunityController.community_exists(conn, id: community_id),
         {:ok, _} <- insert(conn, changeset), do:
      conn
      |> put_status(:created)
      |> render(DiscussionView, "create.json", discussion: discussion)
  end

  def read(conn, %{"id" => id}) do
    %{id: user_id} = Flux.Guardian.Plug.current_resource(conn)

    with {:ok, discussion} <- discussion_exists(conn, id),
         {:ok, user} <- Flux.UserController.user_exists(conn, id: user_id),
         {:ok, _} <- Flux.UserCommunityController.user_community_exists(conn, user_id, discussion.community_id), do:
      conn
      |> put_status(:ok)
      |> render(DiscussionView, "read.json", discussion: discussion)
  end

  def update(conn, %{"id" => id} = params) do
    %{id: user_id} = Flux.Guardian.Plug.current_resource(conn)

    with {:ok, discussion} <- discussion_exists(conn, id),
         {:ok, user} <- Flux.UserController.user_exists(conn, id: user_id),
         {:ok, _} <- Flux.UserCommunityController.user_community_exists(conn, user_id, discussion.community_id),
         {:ok, _} <- update_changeset(conn, discussion, params), do:
      conn
      |> put_status(:ok)
      |> render(DiscussionView, "update.json", discussion: discussion)
  end

  def delete(conn, %{"id" => id}) do
    %{id: user_id} = Flux.Guardian.Plug.current_resource(conn)
    
    with {:ok, discussion} <- discussion_exists(conn, id),
         {:ok, user} <- Flux.UserController.user_exists(conn, id: user_id),
         {:ok, _} <- Flux.UserCommunityController.user_community_exists(conn, user_id, discussion.community_id), do:
      Repo.delete(discussion)
      conn 
      |> put_status(:ok)
      |> render(DiscussionView, "delete.json")
  end

  def discussion_exists(conn, id) do
    discussion = Repo.get_by(Discussion, %{id: id})
    case discussion do
      nil -> 
        conn
        |> put_status(:not_found)
        |> render(DiscussionView, "not_found.json")
      _ -> {:ok, discussion}
    end
  end

  def user_discussion_exists_no_conn(user_id, discussion_id) do
    case Repo.get_by(Flux.Discussion, id: discussion_id) do
      nil -> {:error}
      discussion ->
        case Repo.get_by(Flux.User, id: user_id) do
          nil -> {:error}
          user ->
            case Repo.get_by(Flux.UserCommunity, %{user_id: user.id, community_id: discussion.community_id}) do
              nil -> {:error}
              user_community ->
                {:ok, discussion, user}
            end
        end
    end
  end

  defp update_changeset(conn, discussion, params) do
    changeset = Discussion.changeset(discussion, params)
    case Repo.update(changeset) do
      {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(Flux.ChangesetView, "error.json", changeset: changeset)
      _ -> {:ok, changeset}
    end
  end
end