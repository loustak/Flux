defmodule Flux.Mixfile do
  use Mix.Project

  def project do
    [
      app: :flux,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      # The main module of the application
      mod: {Flux, []},
      # Extra applications to load
      extra_applications: [:logger, :scrivener_ecto],
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:flux), do: ["lib", "web", "flux/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # The framework used to distribute web pages
      {:phoenix, "~> 1.3.2"},
      # Front-end to Phoenix publisher/subscriber layer.
      {:phoenix_pubsub, "~> 1.0"},
      # Library to dialog with a database (postgre / mysql)
      {:phoenix_ecto, "~> 3.2"},
      # Postgre SQL driver for elixir
      {:postgrex, ">= 0.0.0"},
      # Internalization and localisation system
      {:gettext, "~> 0.11"},
      # Web server
      {:cowboy, "~> 1.0"},
      # Hashing library
      {:argon2_elixir, "~> 1.3"},
      # Request authentificator
      {:guardian, "~> 1.0.1"},
      # To controll access origins
      {:cors_plug, "~> 1.5"},
      # Use to paginate queries
      {:scrivener_ecto, "~> 1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "flux": ["ecto.create --quiet", "ecto.migrate", "flux"]
    ]
  end
end
