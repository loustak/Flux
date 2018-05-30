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

  scope "/", Flux do
    pipe_through :api

    # public part
    post "/users", UserController, :create
    post "/token", TokenController, :create

    # authentified part
    pipe_through :auth

    get "/users", UserController, :read
    get "/users/communities", UserController, :communities
    delete "/users", UserController, :delete

    get "/token/refresh", TokenController, :refresh

    scope "/communities" do
      post "/", CommunityController, :create
      get "/:id", CommunityController, :read
      put "/:id", CommunityController, :update
      delete "/:id", CommunityController, :delete
      get "/:id/users", CommunityController, :users
      post "/:id/join", UserCommunityController, :create
      delete "/:id/quit", UserCommunityController, :delete

      post "/:community_id/discussions", DiscussionController, :create
    end

    scope "/discussions" do
      get "/:id", DiscussionController, :read
      put "/:id", DiscussionController, :update
      delete "/:id", DiscussionController, :delete
      post "/:id/join", UserDiscussionController, :create
      delete "/:id/quit", UserDiscussionController, :delete
    end
  end

  # at this point, the ressource was not found: send a generic error
  match :*, "/*path", Flux.ApiController, :ressource_not_found
end