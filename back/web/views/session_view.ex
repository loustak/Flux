defmodule Flux.SessionView do
  use Flux.Web, :view

  def render("show.json", %{user: user, jwt: jwt}) do
    %{
      user: render_one(user, Flux.UserView, "user.json"),
      token: jwt
    }
  end

  def render("token.json", %{token: token}) do
    %{token: token}
  end

  def render("error.json", _) do
    %{error: "Invalid email or password"}
  end

  def render("delete.json", _) do
    %{status: "deleted"}
  end

  def render("jwt_invalid.json", _) do
    %{error: "no jwt token not found or is invalid"}
  end

  def render("forbidden.json", %{error: error}) do
    %{error: error}
  end
end