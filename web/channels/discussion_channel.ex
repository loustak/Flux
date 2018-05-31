defmodule Flux.DiscussionChannel do
  use Flux.Web, :channel

  def join("discussion:" <> discussion_id, _params, socket) do
    discussion = Repo.get_by(Flux.Discussion, id: discussion_id)

    response = %{
      discussion: Phoenix.View.render_one(discussion, Flux.DiscussionView, "read.json"),
    }

    {:ok, response, assign(socket, :discussion, discussion)}
  end

  def terminate(_reason, socket) do
    {:ok, socket}
  end
end