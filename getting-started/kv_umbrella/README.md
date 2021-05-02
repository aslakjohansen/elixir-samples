# KvUmbrella

**TODO: Add description**

## Testing

First, (re)start (it will fail on second try) the `bar` node (on a non-default port):
```shell
/elixir-samples/getting-started/kv_umbrella/apps/kv_server$ PORT=4041 iex --sname bar -S mix
```

Then, run the tests through the `foo` node:
```shell
/elixir-samples/getting-started/kv_umbrella$ elixir --sname foo -S mix test
```

