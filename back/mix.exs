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
      mod: {Flux.Application, []},
      extra_applications: [:logger, :runtime_tools, :bcrypt_elixir]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

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
      {:bcrypt_elixir, "~> 1.0.7"},
      # Request authentificator
      {:guardian, "~> 1.0.1"},
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
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
