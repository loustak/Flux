defmodule Flux.UserRoomFlux do
  use Flux.ModelCase

  alias Flux.UserRoom

  @valid_attrs %{}
  @invalid_attrs %{}

  flux "changeset with valid attributes" do
    changeset = UserRoom.changeset(%UserRoom{}, @valid_attrs)
    assert changeset.valid?
  end

  flux "changeset with invalid attributes" do
    changeset = UserRoom.changeset(%UserRoom{}, @invalid_attrs)
    refute changeset.valid?
  end
end
