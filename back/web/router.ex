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
    post "/token", TokenController, :create

    # authentified part
    pipe_through :auth

    delete "/users", UserController, :delete

    get "/token/refresh", TokenController, :refresh

    # rooms
    scope "/rooms" do 
      post "/", RoomController, :create
    end
  end

  # at this point, the ressource was not found. send a generic error
  match :*, "/*path", Flux.ApiController, :ressource_not_found
end