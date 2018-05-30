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
config :flux, Flux.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "A1GuJaJHegJ/1WljJGQuKXrkz0lERFTdeFYsjmq8kFdIAaFyLD2J74ETD319GZvz",
  render_errors: [view: Flux.ErrorView, accepts: ~w(json)],
  pubsub: [name: Flux.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures CORS plug
config :cors_plug,
  origin: ["http://localhost:3000"],
  max_age: 86400,
  methods: ["GET", "POST", "DELETE", "PUT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures the authentifcation layer
config :flux, Flux.Guardian,
  issuer: "Flux",
  secret_key: "MeK7u5yrDQQqkZRTfvsXX8WvwrdN3tTcDiAwmeB2DvXnXCEmVqkRfP6fGZdesyTW"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
