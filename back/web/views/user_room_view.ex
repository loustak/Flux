defmodule Flux.UserRoomView do
  use Flux.Web, :view

  def render("create.json", %{room: room}) do
    %{success: 
      %{
        detail: "room joined",
        room: render(Flux.RoomView, "read.json", room: room)
      }
    }
  end

  def render("delete.json", _params) do
    %{success: %{detail: "room exited"}}
  end

  def render("users.json", %{users: users}) do
    %{
      success: %{detail: "users read"},
      users: render_many(users, Flux.UserView, "read.json")
    }
  end

  def render("not_found.json", _params) do
    %{error: %{detail: "user room not found"}}
  end
end