defmodule Flux.UserCommunityView do
  use Flux.Web, :view

  def render("create.json", %{community: community}) do
    %{success: 
      %{
        detail: "community joined",
        community: render(Flux.CommunityView, "read.json", community: community)
      }
    }
  end

  def render("delete.json", _params) do
    %{success: %{detail: "community exited"}}
  end

  def render("not_found.json", _params) do
    %{error: %{detail: "user community not found"}}
  end
end