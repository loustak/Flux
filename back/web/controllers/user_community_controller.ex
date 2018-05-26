defmodule Flux.UserCommunityController do
  use Flux.Web, :controller

  alias Flux.UserCommunity
  alias Flux.UserCommunityView

  defp insert(conn, changeset) do
    case Repo.insert(changeset) do
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Flux.ChangesetView, "error.json", changeset: changeset)
      _ -> conn
    end
  end

  def create(conn, %{"id" => community_id}) do
    %{id: user_id} = Flux.Guardian.Plug.current_resource(conn)
    changeset = UserCommunity.changeset(%UserCommunity{}, %{user_id: user_id, community_id: community_id})

    with {:ok, community} <- Flux.CommunityController.community_exists(conn, id: community_id),
                        insert(conn, changeset), do:
        conn
        |> put_status(:created)
        |> render(UserCommunityView, "create.json", community: community)
  end

  def delete(conn, %{"id" => community_id}) do
    %{id: user_id} = Flux.Guardian.Plug.current_resource(conn)

    with {:ok, user_community} <- user_community_exists(conn, user_id, community_id), do:
        Repo.delete(user_community)
        conn
        |> put_status(:ok)
        |> render(UserCommunityView, "delete.json")
  end

  def user_community_exists(conn, user_id, community_id) do
    user_community = Repo.get_by(UserCommunity, %{user_id: user_id, community_id: community_id})
    case user_community do
      nil -> 
        conn
        |> put_status(:not_found)
        |> render(UserCommunityView, "not_found.json")
      _ -> {:ok, user_community}
    end
  end
end