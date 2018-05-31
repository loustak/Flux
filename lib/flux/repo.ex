defmodule Flux.Repo do
  use Ecto.Repo, otp_app: :flux
  use Scrivener, page_size: 25
end
