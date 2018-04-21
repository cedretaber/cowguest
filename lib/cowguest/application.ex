defmodule Cowguest.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do

    redis_host = Application.get_env(:redix, :host)
    redis_port = Application.get_env(:redix, :port)
    redis_database = Application.get_env(:redix, :database)

    children = [
      Plug.Adapters.Cowboy2.child_spec(
        scheme: :http,
        plug: Cowguest.Router,
        options: [port: 4000]
      ),
      {Redix, [[host: redis_host, port: redis_port, database: redis_database], [name: :redix]]}
    ]

    IO.puts("Server start on localhost:4000.")

    opts = [strategy: :one_for_one, name: Cowguest.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
