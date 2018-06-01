defmodule Flux.CommunityView do
  use Flux.Web, :view

  def render("read.json", %{community: community}) do
    %{
      id: community.id,
      creator: community.user_id,
      name: community.name,
      public: community.public,
      joinable: community.joinable
    }
  end

  def render("create.json", %{community: community}) do
    %{
      success: %{detail: "community created"},
      community: render("read.json", %{community: community})
    }
  end

  def render("users.json", %{users: users}) do
    %{
      success: %{detail: "users read"},
      users: render_many(users, Flux.UserView, "read.json")
    }
  end

  def render("discussions.json", %{discussions: discussions}) do
    %{
      success: %{detail: "discussions read"},
      discussions: render_many(discussions, Flux.DiscussionView, "read.json")
    }
  end

  def render("update.json", %{community: community}) do
    %{
      success: %{detail: "community updated"},
      community: render("read.json", %{community: community})
    }
  end

  def render("delete.json", _params) do
    %{success: %{detail: "community deleted"}}
  end

  def render("not_found.json", _params) do
    %{error: %{detail: "community not found"}}
  end
end
