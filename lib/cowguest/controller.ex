defmodule Cowguest.Controller do
  @moduledoc false

  defmacro __using__(opts) do
    quote location: :keep do
      import Cowguest.Controller

      use Plug.Builder, unquote(opts)
    end
  end

  def to_json(value) do
    Poison.encode(value)
  end
end
