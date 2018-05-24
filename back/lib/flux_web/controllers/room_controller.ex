defmodule FluxWeb.RoomController do
  use FluxWeb, :controller

  alias Flux.Flux
  alias Flux.Flux.Room

  action_fallback FluxWeb.FallbackController

  def index(conn, _params) do
    rooms = Flux.list_rooms()
    render(conn, "index.json", rooms: rooms)
  end

  def create(conn, %{"room" => room_params}) do
    with {:ok, %Room{} = room} <- Flux.create_room(room_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", room_path(conn, :show, room))
      |> render("show.json", room: room)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Flux.get_room!(id)
    render(conn, "show.json", room: room)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Flux.get_room!(id)

    with {:ok, %Room{} = room} <- Flux.update_room(room, room_params) do
      render(conn, "show.json", room: room)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Flux.get_room!(id)
    with {:ok, %Room{}} <- Flux.delete_room(room) do
      send_resp(conn, :no_content, "")
    end
  end
end
