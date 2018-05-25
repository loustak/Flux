defmodule Flux.UserRoomView do
  use Flux.Web, :view

  def render("create.json", _params) do
    %{success: %{detail: "user joined a room"}}
  end
end