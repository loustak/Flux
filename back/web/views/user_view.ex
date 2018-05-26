defmodule Flux.UserView do
  use Flux.Web, :view

  def render("read.json", %{user: user}) do
    %{
      username: user.username,
      email: user.email,
    }
  end

  def render("create.json", %{user: user}) do
    %{
      success: %{detail: "user created"},
      user: render(Flux.UserView, "read.json", %{user: user})
    }
  end

  def render("delete.json", _) do
    %{success: %{detail: "user deleted"}}
  end 

  def render("communities.json", %{communities: communities}) do
    %{
      success: %{detail: "communities read"},
      communities: render_many(communities, Flux.CommunityView, "show.json")
    }
  end

  def render("not_found.json", _) do
    %{error: %{detail: "user not found"}}
  end
end