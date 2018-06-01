defmodule Flux.DiscussionChannel do
  use Flux.Web, :channel

  def join("discussion:" <> discussion_id, _params, socket) do
    case Flux.UserDiscussionController.user_discussion_exists_no_conn(socket.assigns.current_user.id, discussion_id) do
      {:ok, _} ->
        discussion = Repo.get_by(Flux.Discussion, id: discussion_id)
        page = 
          Flux.Message
          |> where([m], m.discussion_id == ^discussion_id)
          |> order_by([desc: :inserted_at, desc: :id])
          |> preload(:user)
          |> Flux.Repo.paginate()

        response = %{
          discussion: Phoenix.View.render_one(discussion, Flux.DiscussionView, "read.json"),
          user: Phoenix.View.render_one(socket.assigns.current_user, Flux.UserView, "read.json"),
          messages: Phoenix.View.render_many(page.entries, Flux.MessageView, "read.json"),
          pagination: Flux.PaginationView.pagination(page)
        }

        {:ok, response, assign(socket, :discussion, discussion)}
      {:error, _} -> 
        {:error, %{reason: "you are not part of this discussion"}}
    end
  end

  def handle_in("new_message", params, socket) do
    # Here we have already checked the use appartenance to the discussion 
    changeset = Flux.Message.changeset(%Flux.Message{}, %{discussion_id: socket.assigns.discussion.id, 
      user_id: socket.assigns.current_user.id, text: params})

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