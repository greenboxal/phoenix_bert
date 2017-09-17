defmodule PhoenixBert.ConnTest do
  use ExUnit.Case, async: true

  import PhoenixBert.Conn
  import Plug.Test
  import Plug.Conn

  @test_input %{foo: :bar}
  @test_result <<131, 104, 3, 100, 0, 4, 98, 101, 114, 116, 100, 0, 4, 100, 105,
              99, 116, 108, 0, 0, 0, 1, 104, 2, 100, 0, 3, 102, 111, 111, 100,
              0, 3, 98, 97, 114, 106>>

  test "encodes content to bert" do
    conn = bert(conn(:get, "/"), @test_input)
    assert conn.resp_body == @test_result
    assert get_resp_content_type(conn) == "application/x-bert"
    refute conn.halted
  end

  test "allows status injection on connection" do
    conn = conn(:get, "/") |> put_status(400)
    conn = bert(conn, @test_input)
    assert conn.resp_body == @test_result
    assert conn.status == 400
  end

  test "allows content-type injection on connection" do
    conn = conn(:get, "/") |> put_resp_content_type("application/vnd.api+x-bert")
    conn = bert(conn, @test_input)
    assert conn.resp_body == @test_result
    assert get_resp_header(conn, "content-type") ==
      ["application/vnd.api+x-bert; charset=utf-8"]
  end

  defp get_resp_content_type(conn) do
    [header]  = get_resp_header(conn, "content-type")
    header |> String.split(";") |> Enum.fetch!(0)
  end
end
