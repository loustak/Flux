defmodule Flux.DiscussionView do
  use Flux.Web, :view

  def render("read.json", %{discussion: discussion}) do
    %{name: discussion.name}
  end

  def render("create.json", %{discussion: discussion}) do
    %{
      success: %{detail: "discussion created"},
      discussion: render("read.json", discussion: discussion)
    }
  end

  def render("update.json", %{discussion: discussion}) do
    %{
      success: %{detail: "discussion updated"},
      discussion: render("read.json", discussion: discussion)
    }
  end

  def render("delete.json", _) do
    %{success: %{detail: "discussion deleted"}}
  end

  def render("not_found.json", _) do
    %{error: %{detail: "discussion not found"}}
  end
end
