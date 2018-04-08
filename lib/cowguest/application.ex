defmodule Cowguest.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Cowguest, [])
    ]

    opts = [strategy: :one_for_one, name: Cowguest.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
