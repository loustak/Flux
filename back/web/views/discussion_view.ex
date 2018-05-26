defmodule Flux.DiscussionView do
  use Flux.Web, :view

  def render("index.json", %{discussions: discussions}) do
    %{data: render_many(discussions, Flux.DiscussionView, "discussion.json")}
  end

  def render("show.json", %{discussion: discussion}) do
    %{data: render_one(discussion, Flux.DiscussionView, "discussion.json")}
  end

  def render("discussion.json", %{discussion: discussion}) do
    %{id: discussion.id,
      name: discussion.name}
  end
end
