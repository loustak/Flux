defmodule Flux.UserDiscussionControllerTest do
  use Flux.ConnCase

  alias Flux.UserDiscussion
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_discussion_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user_discussion = Repo.insert! %UserDiscussion{}
    conn = get conn, user_discussion_path(conn, :show, user_discussion)
    assert json_response(conn, 200)["data"] == %{"id" => user_discussion.id,
      "user_id" => user_discussion.user_id,
      "discussion_id" => user_discussion.discussion_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_discussion_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_discussion_path(conn, :create), user_discussion: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(UserDiscussion, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_discussion_path(conn, :create), user_discussion: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user_discussion = Repo.insert! %UserDiscussion{}
    conn = put conn, user_discussion_path(conn, :update, user_discussion), user_discussion: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(UserDiscussion, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_discussion = Repo.insert! %UserDiscussion{}
    conn = put conn, user_discussion_path(conn, :update, user_discussion), user_discussion: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user_discussion = Repo.insert! %UserDiscussion{}
    conn = delete conn, user_discussion_path(conn, :delete, user_discussion)
    assert response(conn, 204)
    refute Repo.get(UserDiscussion, user_discussion.id)
  end
end
