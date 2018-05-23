defmodule Flux.ConnCase do
  @moduledoc """
  This module defines the flux case to be used by
  fluxs that require setting up a connection.

  Such fluxs rely on `Phoenix.ConnFlux` and also
  import other functionality to make it easier
  to build and query models.

  Finally, if the flux case interacts with the database,
  it cannot be async. For this reason, every flux runs
  inside a transaction which is reset at the beginning
  of the flux unless the flux case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for fluxing with connections
      use Phoenix.ConnFlux

      alias Flux.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import Flux.Router.Helpers

      # The default endpoint for fluxing
      @endpoint Flux.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Flux.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Flux.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnFlux.build_conn()}
  end
end
