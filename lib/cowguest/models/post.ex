defmodule Cowguest.Models.Post do
  @moduledoc false

  @derive [Poison.Encoder]

  defstruct [:text, :name]
end
