defmodule Flux.ErrorViewFlux do
  use Flux.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for fluxing custom views
  import Phoenix.View

  flux "renders 404.json" do
    assert render(Flux.ErrorView, "404.json", []) ==
           %{errors: %{detail: "Page not found"}}
  end

  flux "render 500.json" do
    assert render(Flux.ErrorView, "500.json", []) ==
           %{errors: %{detail: "Internal server error"}}
  end

  flux "render any other" do
    assert render(Flux.ErrorView, "505.json", []) ==
           %{errors: %{detail: "Internal server error"}}
  end
end
