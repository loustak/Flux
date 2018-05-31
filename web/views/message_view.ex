defmodule Flux.MessageView do
  use Flux.Web, :view

  def render("read.json", %{message: message}) do
    %{
      id: message.id,
      user_id: message.user_id,
      text: message.text,
    }
  end
end