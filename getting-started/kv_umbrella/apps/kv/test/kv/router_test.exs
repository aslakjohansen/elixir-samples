defmodule KV.RouterTest do
  use ExUnit.Case, async: true
  
  @tag :distributed
  test "route requests across nodes" do
    assert KV.Router.route("hello", Kernel, :node, []) ==
           :foo@thera
    assert KV.Router.route("world", Kernel, :node, []) ==
           :bar@thera
  end

  test "raises on unknown entries" do
    assert_raise RuntimeError, ~r/could not find entry/, fn ->
      KV.Router.route(<<0>>, Kernel, :node, [])
    end
  end
end

