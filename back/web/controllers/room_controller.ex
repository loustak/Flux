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
    room = Repo.get_by(Flux.Room, id: id)

    case room do
      nil -> 
        conn
        |> put_status(:not_found)
        |> render(Flux.RoomView, "not_found.json")
      _ -> 
        conn 
        |> put_status(:ok)
        |> render(Flux.RoomView, "show.json", room: room)
    end
  end

  def update(conn, %{"id" => id} = data) do
    room = Repo.get_by(Flux.Room, id: id)

    case room do
      nil ->
        conn
        |> put_status(:not_found)
        |> render(Flux.RoomView, "not_found.json")
      _ ->
        changeset = Room.changeset(room, data)
        case Repo.update(changeset) do
          {:ok, room} ->
            conn
            |> put_status(:ok)
            |> render(Flux.RoomView, "update.json", room: room)

          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> render(Flux.ChangesetView, "error.json", changeset: changeset)
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Repo.get_by(Flux.Room, id: id)

    case room do
      nil -> 
        conn
        |> put_status(:not_found)
        |> render(Flux.RoomView, "not_found.json")
      _ -> 
        Repo.delete(room)
        conn 
        |> put_status(:ok)
        |> render(Flux.RoomView, "delete.json")
    end
  end
end
