defmodule Flux.TokenController do
  use Flux.Web, :controller

  def create(conn, params) do
    case authenticate(params) do
      {:ok, user} ->
        conn = Flux.Guardian.Plug.sign_in(conn, user, %{claim: "access"}, ttl: {30, :days})
        token = Flux.Guardian.Plug.current_token(conn)

        conn
        |> put_status(:created)
        |> render(Flux.TokenView, "created.json", token: token)
      :error ->
        conn
        |> put_status(:unauthorized)
        |> render("auth_error.json")
    end
  end

  def refresh(conn, _params) do
    token = Flux.Guardian.Plug.current_token(conn)

    id = Flux.Guardian.Plug.current_resource(conn)
    user = Repo.get_by(Flux.User, id)

    case user do
      nil -> 
        conn
        |> put_status(:not_found)
        |> render(Flux.UserView, "not_found.json")
      _ -> 
        {:ok, {_old_token, _old_claims}, {new_token, _new_claims}} = Flux.Guardian.refresh(token, ttl: {30, :days})
        conn
        |> put_status(:ok)
        |> render(Flux.TokenView, "refresh.json", token: new_token)
      end
  end

  defp authenticate(%{"email" => email, "password" => password}) do
    user = Repo.get_by(Flux.User, email: String.downcase(email))

    case check_password(user, password) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp authenticate(_) do
    :error
  end

  defp check_password(user, password) do
    case user do
      nil -> Argon2.no_user_verify()
      _ -> Argon2.verify_pass(password, user.password_hash)
    end
  end
end