defmodule Flux.UserDiscussionView do
  use Flux.Web, :view

  def render("create.json", %{discussion: discussion}) do
    %{success: 
      %{
        detail: "discussion joined",
        discussion: render(Flux.DiscussionView, "read.json", discussion: discussion)
      }
    }
  end

  def render("delete.json", _params) do
    %{success: %{detail: "discussion exited"}}
  end

  def render("not_found.json", _) do
    %{error: %{detail: "user discussion not found"}}
  end
end
