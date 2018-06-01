defmodule Flux.MessageController do
  use Flux.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: Flux.SessionController

  def read(conn, params) do
    last_message_time = params["last_message_time"] || 0
    discussion = Repo.get!(Flux.Discussion, params["discussion_id"])

    page =
      Flux.Message
      |> where([m], m.discussion_id == ^discussion.id)
      |> where([m], m.inserted_at < ^last_message_time)
      |> order_by([asc: :inserted_at, asc: :id])
      |> preload(:user)
      |> Flux.Repo.paginate()

    render(conn, "read.json", %{messages: page.entries, pagination: Flux.PaginationView.pagination(page)})
  end
end