use Mix.Config

# We don't run a server during flux. If one is required,
# you can enable the server option below.
config :flux, Flux.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during flux
config :logger, level: :warn

# Configure your database
config :flux, Flux.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "flux_flux",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
