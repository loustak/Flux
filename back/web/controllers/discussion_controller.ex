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
      _ -> conn
    end
  end

  def create(conn, %{"community_id" => community_id} = params) do
    changeset = Discussion.changeset(%Discussion{}, params)
    
    with {:ok, discussion} <- Flux.CommunityController.community_exists(conn, id: community_id),
                              insert(conn, changeset), do:
      conn
      |> put_status(:created)
      |> render(DiscussionView, "create.json", discussion: discussion)
  end

  def read(conn, %{"id" => id}) do
    with {:ok, discussion} <- discussion_exists(conn, id), do:
      conn
      |> put_status(:ok)
      |> render(DiscussionView, "read.json", discussion: discussion)
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, discussion} <- discussion_exists(conn, id), 
                        update_changeset(conn, discussion, params), do:
          conn
          |> put_status(:ok)
          |> render(DiscussionView, "update.json", discussion: discussion)
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, discussion} <- discussion_exists(conn, id), do:
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

  defp update_changeset(conn, discussion, params) do
    changeset = Discussion.changeset(discussion, params)
    case Repo.update(changeset) do
      {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(Flux.ChangesetView, "error.json", changeset: changeset)
      _ -> {:ok, discussion}
    end
  end
end
