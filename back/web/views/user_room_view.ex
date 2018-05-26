defmodule Flux.UserRoomView do
  use Flux.Web, :view

  def render("create.json", %{room: room}) do
    %{success: 
      %{
        detail: "room joined",
        room: render(Flux.RoomView, "show.json", room: room)
      }
    }
  end

  def render("delete.json", _params) do
    %{success: %{detail: "room exited"}}
  end

  def render("not_found.json", _params) do
    %{error: %{detail: "user room not found"}}
  end
end