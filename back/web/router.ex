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
    post "/users", UserController, :create
    post "/session", SessionController, :create

    # authentified part
    pipe_through :auth

    get "/session/refresh", SessionController, :refresh
    get "/session", SessionController, :read
    delete "/session", SessionController, :delete

    get "/users/:id/rooms", UserController, :rooms
    resources "/rooms", RoomController, only: [:index, :create]
    post "/rooms/:id/join", RoomController, :join
  end
end