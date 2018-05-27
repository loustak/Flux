defmodule Flux.TokenView do
  use Flux.Web, :view

  def render("created.json", %{token: token}) do
    %{
      success: %{detail: "user authentified"},
      token: token
    }
  end

  def render("refresh.json", %{token: token}) do
    %{
      success: %{detail: "token refreshed"},
      token: token
    }
  end

  def render("auth_error.json", _) do
    %{error: %{detail: "could not authentificate the user"}}
  end
end