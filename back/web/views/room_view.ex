defmodule Flux.RoomView do
  use Flux.Web, :view

  def render("index.json", %{rooms: rooms}) do
    %{data: render_many(rooms, Flux.RoomView, "room.json")}
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, Flux.RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{id: room.id,
      name: room.name,
      public: room.public,
      joinable: room.joinable,
      joinable_invitation: room.joinable_invitation}
  end
end
