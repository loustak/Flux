defmodule FluxWeb.Router do
  use FluxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FluxWeb do
    pipe_through :api
  end
end
