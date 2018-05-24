defmodule Flux.RoomTest do
  use Flux.ModelCase

  alias Flux.Room

  @valid_attrs %{joinable: true, joinable_invitation: true, name: "some name", public: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Room.changeset(%Room{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Room.changeset(%Room{}, @invalid_attrs)
    refute changeset.valid?
  end
end
