defmodule FluxWeb.RoomView do
  use FluxWeb, :view
  alias FluxWeb.RoomView

  def render("index.json", %{rooms: rooms}) do
    %{data: render_many(rooms, RoomView, "room.json")}
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{id: room.id,
      name: room.name,
      public: room.public,
      joinable: room.joinable,
      joinable_invitation: room.joinable_invitation}
  end
end
