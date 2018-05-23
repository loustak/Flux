defmodule Flux.RoomFlux do
  use Flux.ModelCase

  alias Flux.Room

  @valid_attrs %{name: "some name", topic: "some topic"}
  @invalid_attrs %{}

  flux "changeset with valid attributes" do
    changeset = Room.changeset(%Room{}, @valid_attrs)
    assert changeset.valid?
  end

  flux "changeset with invalid attributes" do
    changeset = Room.changeset(%Room{}, @invalid_attrs)
    refute changeset.valid?
  end
end
