
defmodule Flux.UserController do
  use Flux.Web, :controller

  alias Flux.User

  def create(conn, params) do
    changeset = User.registration_changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Flux.Guardian.Plug.sign_in(user)
        |> send_resp(200, Poison.encode!(%{status: "success"}))

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Flux.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def rooms(conn, _params) do
    id = Guardian.Plug.current_resource(conn)
    user = Repo.get_by(Flux.User, id)
    rooms = Repo.all(Ecto.assoc(user, :rooms))
    render(conn, Flux.RoomView, "index.json", %{rooms: rooms})
  end
end