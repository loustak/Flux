defmodule Flux.UserRoomController do
  use Flux.Web, :controller

  alias Flux.UserRoom

  defp create(conn, params) do
    # changeset = UserRoom.changeset(%UserRoom{}, %{"user_id" => user_id, "room_id" => params.id})

    # case Repo.insert(changeset) do
    #   {:ok, room} ->
    #     conn
    #     |> put_status(:created)
    #     |> render(Flux.UserRoomView, "create.json")

    #   {:error, changeset} ->
    #     conn
    #     |> put_status(:unprocessable_entity)
    #     |> render(Flux.ChangesetView, "error.json", changeset: changeset)
    # end
  end
end