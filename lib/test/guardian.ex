defmodule Flux.Guardian do
  use Guardian, otp_app: :flux

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(claims) do
    # here we say that the subject of the token is a user id
    {:ok, %{id: claims["sub"]}}
  end
end