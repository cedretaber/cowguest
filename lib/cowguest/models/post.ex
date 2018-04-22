defmodule Cowguest.Models.Post do
  @moduledoc false

  @derive [Poison.Encoder]

  defstruct [:id, :text, :name]
end
