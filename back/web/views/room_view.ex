defmodule Flux.RoomView do
  use Flux.Web, :view

  def render("read.json", %{room: room}) do
    %{
      name: room.name,
      public: room.public,
      joinable: room.joinable
    }
  end

  def render("create.json", %{room: room}) do
    %{
      success: %{detail: "room created"},
      room: render(Flux.RoomView, "read.json", %{room: room})
    }
  end

  def render("update.json", %{room: room}) do
    %{
      success: %{detail: "room updated"},
      room: render(Flux.RoomView, "read.json", %{room: room})
    }
  end

  def render("delete.json", _params) do
    %{success: %{detail: "room deleted"}}
  end

  def render("not_found.json", _params) do
    %{error: %{detail: "room not found"}}
  end
end
