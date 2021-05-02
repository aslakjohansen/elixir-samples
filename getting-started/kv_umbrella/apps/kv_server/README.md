# KVServer

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `kv_server` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:kv_server, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/kv_server](https://hexdocs.pm/kv_server).

## Testing

Start `bar` with a nonstandard port to avoid conflicts:

```shell
/elixir-samples//getting-started/kv_umbrella/apps/kv_server$ PORT=4041 iex --sname bar -S mix
```

Run test as `foo`:

```shell
/elixir-samples/getting-started/kv_umbrella/apps/kv_server$ elixir --sname foo -S mix test
```

