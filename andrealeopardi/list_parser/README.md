# ListParser

[Source](https://andrealeopardi.com/posts/tokenizing-and-parsing-in-elixir-using-leex-and-yecc/)

## Compilation

```shell
mix compile
```

## Use

Open `iex` session:

```shell
iex -S mix
```

And run:

```iex
iex(1)> ListParser.parse("[:foo, [1], [:bar, [2, 3]]]")
[:foo, [1], [:bar, [2, 3]]]
```

