defmodule Flux.MessageView do
  use Flux.Web, :view

  def render("read.json", %{message: message}) do
    %{
      id: message.id,
      user: %{
        id: message.user.id,
        username: message.user.username,
      },
      time: message.inserted_at,
      text: message.text,
    }
  end

  def render("page.json", %{messages: messages, pagination: pagination}) do
    %{
      messages: render_many(messages, Flux.MessageView, "read.json"),
      pagination: pagination
    }
  end
end