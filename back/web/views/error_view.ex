defmodule Flux.ErrorView do
  use Flux.Web, :view

  def render("404.json", %{verb: verb, route: route}) do
    %{error: %{detail: "ressource not found", verb: verb, route: route}}
  end

  def render("500.json", _assigns) do
    %{error: %{detail: "internal server error"}}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end
end
