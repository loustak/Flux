defmodule Flux.RoomController do
  use Flux.Web, :controller

  alias Flux.Room

  def create(conn, params) do
    changeset = Room.changeset(%Room{}, params)

    case Repo.insert(changeset) do
      {:ok, room} ->
        conn
        |> put_status(:created)
        |> render(Flux.RoomView, "create.json", room: room)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Flux.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def read(conn, %{"id" => id}) do
    with {:ok, room} <- room_exists(conn, id: id), do:
      conn
      |> put_status(:ok)
      |> render(Flux.RoomView, "read.json", room: room)
  end

  def users(conn, %{"id" => id}) do
    with {:ok, _} <- room_exists(conn, id: id), do:
      import Ecto.Query, only: [from: 2]
      query = from u in Flux.User, 
              join: ur in Flux.UserRoom,
              where: u.id == ur.user_id and ur.room_id == ^id,
              select: u

      users = Repo.all(query)
      conn 
      |> put_status(:ok)
      |> render(Flux.UserRoomView, "users.json", users: users)
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, room} <- room_exists(conn, id: id), 
                        update_changeset(conn, room, params), do:
          conn
          |> put_status(:ok)
          |> render(Flux.RoomView, "update.json", room: room)
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, room} <- room_exists(conn, id: id), do:
      Repo.delete(room)
      conn 
      |> put_status(:ok)
      |> render(Flux.RoomView, "delete.json")
  end

  def room_exists(conn, id) do
    room = Repo.get_by(Flux.Room, id)
    case room do
      nil -> 
        conn
        |> put_status(:not_found)
        |> render(Flux.RoomView, "not_found.json")
      _ -> {:ok, room}
    end
  end

  defp update_changeset(conn, room, params) do
    changeset = Room.changeset(room, params)
    case Repo.update(changeset) do
      {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(Flux.ChangesetView, "error.json", changeset: changeset)
      _ -> {:ok, room}
    end
  end

end
