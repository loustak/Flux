# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :flux,
  ecto_repos: [Flux.Repo]

# Configures the endpoint
config :flux, FluxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ukECiuqdFFJWngkCR4oRgeJLiO+4BX3biskdoVKfcrysQLcuxb4c2eHIEwv6GR/8",
  render_errors: [view: FluxWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Flux.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
