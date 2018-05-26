defmodule Flux.UserRoomController do
  use Flux.Web, :controller

  alias Flux.UserRoom

  defp insert(conn, changeset) do
    case Repo.insert(changeset) do
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Flux.ChangesetView, "error.json", changeset: changeset)
      _ -> conn
    end
  end

  def create(conn, %{"id" => room_id}) do
    %{id: user_id} = Flux.Guardian.Plug.current_resource(conn)
    changeset = UserRoom.changeset(%UserRoom{}, %{user_id: user_id, room_id: room_id})

    with {:ok, room} <- Flux.RoomController.room_exists(conn, id: room_id),
                        insert(conn, changeset), do:
        conn
        |> put_status(:created)
        |> render(Flux.UserRoomView, "create.json", room: room)
  end

  def delete(conn, %{"id" => room_id}) do
    %{id: user_id} = Flux.Guardian.Plug.current_resource(conn)

    with {:ok, user_room} <- user_room_exists(conn, user_id, room_id), do:
        Repo.delete(user_room)
        conn
        |> put_status(:ok)
        |> render(Flux.UserRoomView, "delete.json")
  end

  def user_room_exists(conn, user_id, room_id) do
    user_room = Repo.get_by(Flux.UserRoom, %{user_id: user_id, room_id: room_id})
    case user_room do
      nil -> 
        conn
        |> put_status(:not_found)
        |> render(Flux.UserRoomView, "not_found.json")
      _ -> {:ok, user_room}
    end
  end
end