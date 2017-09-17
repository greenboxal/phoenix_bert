defmodule PhoenixBert do
  @moduledoc """
  BERT encoder for Phoenix
  """

  @doc ~S"""
  Encodes data to iodata using BERT

  # Examples

      iex> %{hello: "world"} |> PhoenixBert.encode_to_iodata!
      <<131, 104, 3, 100, 0, 4, 98, 101, 114, 116, 100, 0, 4, 100, 105, 99, 116, 108, 0, 0, 0, 1, 104, 2, 100, 0, 5, 104, 101, 108, 108, 111, 109, 0, 0, 0, 5, 119, 111, 114, 108, 100, 106>>
  """
  def encode_to_iodata!(data) do
    Bertex.encode(data)
  end
end
