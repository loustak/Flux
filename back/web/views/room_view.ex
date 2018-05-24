defmodule Flux.RoomView do
  use Flux.Web, :view

  def render("show.json", %{room: room}) do
    %{
      name: room.name,
      public: room.public,
      joinable: room.joinable
    }
  end

  def render("create.json", %{room: room}) do
    %{
      success: %{detail: "room created"},
      room: render(Flux.RoomView, "show.json", %{room: room})
    }
  end
end
