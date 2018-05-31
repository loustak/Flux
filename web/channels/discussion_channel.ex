defmodule Flux.DiscussionChannel do
  use Flux.Web, :channel

  def join("discussion:" <> discussion_id, _params, socket) do
    discussion = Repo.get_by(Flux.Discussion, id: discussion_id)

    page = 
      Flux.Message
      |> where([m], m.discussion_id == ^discussion_id)
      |> order_by([desc: :inserted_at, desc: :id])
      |> preload(:user)
      |> Flux.Repo.paginate()

    response = %{
      discussion: Phoenix.View.render_one(discussion, Flux.DiscussionView, "read.json"),
      messages: Phoenix.View.render_many(page.entries, Flux.MessageView, "read.json"),
      pagination: Flux.PaginationView.pagination(page)
    }

    {:ok, response, assign(socket, :discussion, discussion)}
  end

  def handle_in("new_message", params, socket) do
    require Logger
    Logger.info inspect(socket.assigns.current_user)
    changeset = Flux.Message.changeset(%Flux.Message{}, %{discussion_id: socket.assigns.discussion.id, 
      user_id: String.to_integer(socket.assigns.current_user.id), text: params})

    case Repo.insert(changeset) do
      {:ok, message} ->
        broadcast_message(socket, message)
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, {:error, Phoenix.View.render(Flux.ChangesetView, "error.json", changeset: changeset)}, socket}
    end
  end

  defp broadcast_message(socket, message) do
    message = Repo.preload(message, :user)
    rendered_message = Phoenix.View.render_one(message, Flux.MessageView, "read.json")
    broadcast!(socket, "message_created", rendered_message)
  end

  def terminate(_reason, socket) do
    {:ok, socket}
  end
end