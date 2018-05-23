defmodule Flux.ChannelCase do
  @moduledoc """
  This module defines the flux case to be used by
  channel fluxs.

  Such fluxs rely on `Phoenix.ChannelFlux` and also
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
      # Import conveniences for fluxing with channels
      use Phoenix.ChannelFlux

      alias Flux.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query


      # The default endpoint for fluxing
      @endpoint Flux.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Flux.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Flux.Repo, {:shared, self()})
    end

    :ok
  end
end
