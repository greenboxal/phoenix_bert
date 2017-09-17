defmodule PhoenixBert.ConnTest do
  @moduledoc """
  Conveniences for testing BERT endpoints.
  """

  import Phoenix.ConnTest

  @doc """
  Asserts the given status code, that we have an BERT response and
  returns the decoded BERT response if one was set or sent.

  ## Examples
      body = bert_response(conn, 200)
      assert "can't be blank" in body[:errors]
  """
  @spec bert_response(Conn.t, status :: integer | atom) :: map | no_return
  def bert_response(conn, status) do
    body = response(conn, status)
    _    = response_content_type(conn, :"x-bert")

    Bertex.decode(body)
  end
end
