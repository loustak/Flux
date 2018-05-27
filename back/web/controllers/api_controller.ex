defmodule Flux.ApiController do
  use Flux.Web, :controller

  def ressource_not_found(conn, _params) do
    conn
    |> put_status(:not_found)
    |> render(Flux.ErrorView, "404.json", verb: conn.method, route: conn.request_path)
  end
end