# Producer

Fetch dependencies:
```shell
mix deps.get
```

Run by executing:
```shell
iex -S mix
```

Listen for publications:
```shell
mosquitto_sub -v -t "#"
```

