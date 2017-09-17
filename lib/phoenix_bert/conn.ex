defmodule PhoenixBert.Conn do
  import Plug.Conn

  @doc """
  Sends BERT response.

  ## Examples
      iex> bert conn, %{id: 123}
  """
  def bert(conn, data) do
    send_resp(conn, conn.status || 200, "application/x-bert", Bertex.encode(data))
  end

  defp send_resp(conn, default_status, default_content_type, body) do
    conn
    |> ensure_resp_content_type(default_content_type)
    |> send_resp(conn.status || default_status, body)
  end

  defp ensure_resp_content_type(%{resp_headers: resp_headers} = conn, content_type) do
    if List.keyfind(resp_headers, "content-type", 0) do
      conn
    else
      content_type = content_type <> "; charset=utf-8"
      %{conn | resp_headers: [{"content-type", content_type}|resp_headers]}
    end
  end
end
