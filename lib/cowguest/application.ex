defmodule Cowguest.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy2.child_spec(
        scheme: :http,
        plug: Cowguest.Router,
        options: [port: 4000]
      )
    ]

    opts = [strategy: :one_for_one, name: Cowguest.Supervisor]

    IO.puts("Server start on localhost:4000.")

    Supervisor.start_link(children, opts)
  end
end
