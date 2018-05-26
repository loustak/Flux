defmodule Flux.CommunityController do
  use Flux.Web, :controller

  alias Flux.Community
  alias Flux.CommunityView

  def create(conn, params) do
    changeset = Community.changeset(%Community{}, params)

    case Repo.insert(changeset) do
      {:ok, community} ->
        conn
        |> put_status(:created)
        |> render(CommunityView, "create.json", community: community)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Flux.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def read(conn, %{"id" => id}) do
    with {:ok, community} <- community_exists(conn, id: id), do:
      conn
      |> put_status(:ok)
      |> render(CommunityView, "read.json", community: community)
  end

  def users(conn, %{"id" => id}) do
    with {:ok, _} <- community_exists(conn, id: id), do:
      import Ecto.Query, only: [from: 2]
      query = from u in Flux.User, 
              join: ur in Flux.UserCommunity,
              where: u.id == ur.user_id and ur.community_id == ^id,
              select: u

      users = Repo.all(query)
      conn 
      |> put_status(:ok)
      |> render(CommunityView, "users.json", users: users)
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, community} <- community_exists(conn, id: id), 
                        update_changeset(conn, community, params), do:
          conn
          |> put_status(:ok)
          |> render(CommunityView, "update.json", community: community)
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, community} <- community_exists(conn, id: id), do:
      Repo.delete(community)
      conn 
      |> put_status(:ok)
      |> render(CommunityView, "delete.json")
  end

  def community_exists(conn, id) do
    community = Repo.get_by(Community, id)
    case community do
      nil -> 
        conn
        |> put_status(:not_found)
        |> render(CommunityView, "not_found.json")
      _ -> {:ok, community}
    end
  end

  defp update_changeset(conn, community, params) do
    changeset = Community.changeset(community, params)
    case Repo.update(changeset) do
      {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(Flux.ChangesetView, "error.json", changeset: changeset)
      _ -> {:ok, community}
    end
  end

end
