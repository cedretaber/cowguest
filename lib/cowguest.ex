defmodule Cowguest do
  def start_link do
    routes = [
      {"/", Cowguest.HelloHandler, []}
    ]

    dispatch = :cowboy_router.compile([{:_, routes}])

    opts = [port: 4000]
    env = %{dispatch: dispatch}
    {:ok, _} = :cowboy.start_clear(:http, opts, %{env: env})
  end
end
