
defmodule Flux.UserController do
  use Flux.Web, :controller

  alias Flux.User

  def create(conn, params) do
    changeset = User.registration_changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Flux.Guardian.Plug.sign_in(user)
        |> render(Flux.UserView, "create.json", user: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Flux.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def read(conn, _params) do
    id = Flux.Guardian.Plug.current_resource(conn)
    user = Repo.get_by(Flux.User, id)
    case user do
      nil -> 
        conn
        |> put_status(:not_found)
        |> render(Flux.UserView, "not_found.json")
      _ -> 
        Repo.delete(user)
        conn 
        |> put_status(:ok)
        |> render(Flux.UserView, "read.json")
    end
  end

  def delete(conn, _params) do
    id = Flux.Guardian.Plug.current_resource(conn)
    user = Repo.get_by(Flux.User, id)
    case user do
      nil -> 
        conn
        |> put_status(:not_found)
        |> render(Flux.UserView, "not_found.json")
      _ -> 
        Repo.delete(user)
        conn 
        |> put_status(:ok)
        |> render(Flux.UserView, "delete.json")
    end
  end

end