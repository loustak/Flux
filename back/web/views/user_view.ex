defmodule Flux.UserView do
  use Flux.Web, :view

  def render("user.json", %{user: user}) do
    %{
      username: user.username,
      email: user.email,
    }
  end
end