defmodule Ajedrez.Repo do
  use Ecto.Repo,
    otp_app: :ajedrez,
    adapter: Ecto.Adapters.Postgres
end
