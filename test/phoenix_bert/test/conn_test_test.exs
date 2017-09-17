defmodule PhoenixBert.ConnTestTest do
  use ExUnit.Case, async: true
  use Phoenix.ConnTest

  import PhoenixBert.ConnTest

  @empty_map <<131, 104, 3, 100, 0, 4, 98, 101, 114, 116, 100, 0, 4, 100, 105, 99, 116, 106>>

  test "bert_response/2" do
    assert build_conn(:get, "/") |> put_resp_content_type("application/x-bert")
                           |> resp(200, @empty_map) |> bert_response(:ok) == %{}

    assert build_conn(:get, "/") |> put_resp_content_type("application/vnd.api+x-bert")
                           |> resp(200, @empty_map) |> bert_response(:ok) == %{}

    assert build_conn(:get, "/") |> put_resp_content_type("application/vnd.collection+x-bert")
                           |> resp(200, @empty_map) |> bert_response(:ok) == %{}

    assert build_conn(:get, "/") |> put_resp_content_type("application/vnd.hal+x-bert")
                           |> resp(200, @empty_map) |> bert_response(:ok) == %{}

    assert build_conn(:get, "/") |> put_resp_content_type("application/ld+x-bert")
                           |> resp(200, @empty_map) |> bert_response(:ok) == %{}

    assert_raise RuntimeError,
                 "no content-type was set, expected a x-bert response", fn ->
      build_conn(:get, "/") |> resp(200, "ok") |> bert_response(200)
    end

    assert_raise ArgumentError, fn ->
      build_conn(:get, "/") |> put_resp_content_type("application/x-bert")
                      |> resp(200, "ok") |> bert_response(200)
    end

    assert_raise RuntimeError, ~s(expected response with status 200, got: 400, with body:\n{"error": "oh oh"}), fn ->
      build_conn(:get, "/")
      |> put_resp_content_type("application/x-bert")
      |> resp(400, ~s({"error": "oh oh"}))
      |> bert_response(200)
    end
  end
end
