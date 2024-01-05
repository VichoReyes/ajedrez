import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ajedrez, Ajedrez.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ajedrez_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ajedrez, AjedrezWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "+WudauZbfhYQp6EbPvlTp7LEHKfRUBO1GvSv7KrG5Be6zJf+k7D1x1ixPdUXjhsn",
  server: false

# In test we don't send emails.
config :ajedrez, Ajedrez.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
