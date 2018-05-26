defmodule Flux.UserDiscussionView do
  use Flux.Web, :view

  def render("index.json", %{user_discussions: user_discussions}) do
    %{data: render_many(user_discussions, Flux.UserDiscussionView, "user_discussion.json")}
  end

  def render("show.json", %{user_discussion: user_discussion}) do
    %{data: render_one(user_discussion, Flux.UserDiscussionView, "user_discussion.json")}
  end

  def render("user_discussion.json", %{user_discussion: user_discussion}) do
    %{id: user_discussion.id,
      user_id: user_discussion.user_id,
      discussion_id: user_discussion.discussion_id}
  end
end
