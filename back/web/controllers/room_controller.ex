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
end
