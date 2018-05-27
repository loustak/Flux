defmodule Flux.DiscussionTest do
  use Flux.ModelCase

  alias Flux.Discussion

  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Discussion.changeset(%Discussion{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Discussion.changeset(%Discussion{}, @invalid_attrs)
    refute changeset.valid?
  end
end
