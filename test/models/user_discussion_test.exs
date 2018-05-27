defmodule Flux.UserDiscussionTest do
  use Flux.ModelCase

  alias Flux.UserDiscussion

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserDiscussion.changeset(%UserDiscussion{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserDiscussion.changeset(%UserDiscussion{}, @invalid_attrs)
    refute changeset.valid?
  end
end
