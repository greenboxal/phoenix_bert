defmodule Plug.Parsers.BERT do
  @moduledoc """
  Parses BERT request body.

  # Usage
  
  Pass bert as an acceptable format.

      plug :accepts, ["json", "bert"]
  """

  @behaviour Plug.Parsers
  import Plug.Conn

  def parse(conn, "application", subtype, _headers, opts) do
    if subtype == "x-bert" || String.ends_with?(subtype, "+bert") do
      conn
      |> read_body(opts)
      |> decode
    else
      {:next, conn}
    end
  end

  @doc false
  def parse(conn, _type, _subtype, _headers, _opts) do
    {:next, conn}
  end

  defp decode({:more, _, conn}) do
    {:error, :too_large, conn}
  end

  defp decode({:error, :timeout}) do
    raise Plug.TimeoutError
  end

  defp decode({:error, _}) do
    raise Plug.BadRequestError
  end

  defp decode({:ok, "", conn}) do
    {:ok, %{}, conn}
  end

  defp decode({:ok, body, conn}) do
    {:ok, Bertex.safe_decode(body), conn}
  rescue
    e -> raise Plug.Parsers.ParseError, exception: e
  end
end
