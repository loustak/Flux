defmodule Flux.SessionView do
  use Flux.Web, :view

  def render("session.json", %{user: user, token: token}) do
    %{
      token: token,
      user: render_one(user, Flux.UserView, "user.json")
    }
  end

  def render("auth_error.json", _) do
    %{error: "could not authentificate the user"}
  end

  def render("jwt_error.json", _) do
    %{error: "the jwt token is invalid"}
  end

  def render("token.json", %{token: token}) do
    %{token: token}
  end

  def render("delete.json", _) do
    %{success: "token revoked with success"}
  end
end