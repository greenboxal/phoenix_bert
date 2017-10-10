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
    cond do
      subtype == "x-bert" || String.ends_with?(subtype, "+bert") ->
        conn
        |> read_body(opts)
        |> decode(base64: false)
      subtype == "x-bert-base64" || String.ends_with?(subtype, "+bert-base64") ->
        conn
        |> read_body(opts)
        |> decode(base64: true)
      true ->
        {:next, conn}
    end
  end

  @doc false
  def parse(conn, _type, _subtype, _headers, _opts) do
    {:next, conn}
  end

  defp decode({:more, _, conn}, _) do
    {:error, :too_large, conn}
  end

  defp decode({:error, :timeout}, _) do
    raise Plug.TimeoutError
  end

  defp decode({:error, _}, _) do
    raise Plug.BadRequestError
  end

  defp decode({:ok, "", conn}, _) do
    {:ok, %{}, conn}
  end

  defp decode({:ok, body, conn}, base64: false) do
    {:ok, Bertex.safe_decode(body), conn}
  rescue
    e -> raise Plug.Parsers.ParseError, exception: e
  end

  defp decode({:ok, body, conn}, base64: true) do
    {:ok, Bertex.safe_decode(Base.decode64!(String.trim(body))), conn}
  rescue
    e -> raise Plug.Parsers.ParseError, exception: e
  end
end
