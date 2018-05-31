defmodule Flux.UserSocket do
  use Phoenix.Socket

  channel "discussion:*", Flux.DiscussionChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(%{"token" => token}, socket) do
    case Guardian.Phoenix.Socket.authenticate(socket, Flux.Guardian, token) do
      {:ok, data} ->
        {:ok, assign(socket, :current_user, data.assigns.guardian_default_resource)}
      {:error, _} -> 
        :error
    end
  end

  def connect(_params, _socket), do: :error

  def id(socket), do: "users_socket:#{socket.assigns.current_user.id}"
end
