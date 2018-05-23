defmodule Flux.Router do
  use Flux.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Guardian.Plug.Pipeline, module: Flux.Guardian, error_handler: Flux.GuardianErrorHandler
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end

  scope "/api", Flux do
    pipe_through :api

    # public part
    put "/users", UserController, :create
    post "/session", SessionController, :create

    # authentified part
    pipe_through :auth

    delete "/users", UserController, :delete

    get "/session/refresh", SessionController, :refresh
    delete "/session", SessionController, :delete
  end
end