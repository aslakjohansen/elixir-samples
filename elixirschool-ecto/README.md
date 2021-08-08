This is the result of following [this](https://elixirschool.com/en/lessons/ecto/basics/) guide.

# Setup of PostgreSQL

```console
$ sudo -u postgres psql
psql (12.7 (Ubuntu 12.7-0ubuntu0.20.04.1))
Type "help" for help.

postgres=# CREATE USER someuser WITH ENCRYPTED PASSWORD 'somepassword';
CREATE ROLE
postgres=# ALTER USER someuser CREATEDB;
ALTER ROLE
postgres=# exit
$
```

# Querying

Bindingless query:
```elixir
iex(34)> query = from(Movie, where: [title: "Ready Player One"], select: [:title, :tagline])
#Ecto.Query<from m0 in Friends.Movie, where: m0.title == "Ready Player One",
 select: [:title, :tagline]>
iex(35)> Repo.all(query)                                                                    

12:30:53.357 [debug] QUERY OK source="movies" db=0.8ms queue=1.2ms idle=1152.1ms
SELECT m0."title", m0."tagline" FROM "movies" AS m0 WHERE (m0."title" = 'Ready Player One') []
[
  %Friends.Movie{
    __meta__: #Ecto.Schema.Metadata<:loaded, "movies">,
    actors: #Ecto.Association.NotLoaded<association :actors is not loaded>,
    characters: #Ecto.Association.NotLoaded<association :characters is not loaded>,
    distributor: #Ecto.Association.NotLoaded<association :distributor is not loaded>,
    id: nil,
    tagline: "Something about video games",
    title: "Ready Player One"
  },
  %Friends.Movie{
    __meta__: #Ecto.Schema.Metadata<:loaded, "movies">,
    actors: #Ecto.Association.NotLoaded<association :actors is not loaded>,
    characters: #Ecto.Association.NotLoaded<association :characters is not loaded>,
    distributor: #Ecto.Association.NotLoaded<association :distributor is not loaded>,
    id: nil,
    tagline: "Something about video games",
    title: "Ready Player One"
  },
  %Friends.Movie{
    __meta__: #Ecto.Schema.Metadata<:loaded, "movies">,
    actors: #Ecto.Association.NotLoaded<association :actors is not loaded>,
    characters: #Ecto.Association.NotLoaded<association :characters is not loaded>,
    distributor: #Ecto.Association.NotLoaded<association :distributor is not loaded>,
    id: nil,
    tagline: "Something about video games",
    title: "Ready Player One"
  }
]
iex(36)> 
```

Query with bindings, illustrating the result expression:
```elixir
iex(37)> query = from(m in Movie, where: m.id < 2, select: m.title)
#Ecto.Query<from m0 in Friends.Movie, where: m0.id < 2, select: m0.title>
iex(38)> Repo.all(query)

12:52:55.577 [debug] QUERY OK source="movies" db=1.5ms queue=1.9ms idle=1267.5ms
SELECT m0."title" FROM "movies" AS m0 WHERE (m0."id" < 2) []
["Ready Player One"]
iex(39)> query = from(m in Movie, where: m.id < 2, select: {m.title})
#Ecto.Query<from m0 in Friends.Movie, where: m0.id < 2, select: {m0.title}>
iex(40)> Repo.all(query)

12:54:01.472 [debug] QUERY OK source="movies" db=1.3ms queue=1.3ms idle=1802.7ms
SELECT m0."title" FROM "movies" AS m0 WHERE (m0."id" < 2) []
[{"Ready Player One"}]
iex(41)> 
```

Macro-based queries:
```elixir
iex(43)> Movie \
...(43)>  |> where([m], m.id < 2) \
...(43)>  |> select([m], {m.title}) \
...(43)>  |> Repo.all

12:57:23.304 [debug] QUERY OK source="movies" db=0.7ms idle=1588.4ms
SELECT m0."title" FROM "movies" AS m0 WHERE (m0."id" < 2) []
[{"Ready Player One"}]
iex(44)> 
```

Inline:
```elixir
iex(44)> title = "Ready Player One"
"Ready Player One"
iex(45)> query = from(m in Movie, where: m.title == ^title, select: m.tagline)
#Ecto.Query<from m0 in Friends.Movie, where: m0.title == ^"Ready Player One",
 select: m0.tagline>
iex(46)> Repo.all(query)

13:00:29.789 [debug] QUERY OK source="movies" db=2.1ms queue=5.2ms idle=1854.6ms
SELECT m0."tagline" FROM "movies" AS m0 WHERE (m0."title" = $1) ["Ready Player One"]
["Something about video games", "Something about video games",
 "Something about video games"]
```

# Notes

It would appear that in the many-to-may part of the [associations](https://elixirschool.com/en/lessons/ecto/associations/) lecture the command:

```elixir
Repo.update!(movie_actors_changeset)
```

should be

```elixir
Repo.insert_or_update!(movie_actors_changeset)
```

**Note:** The last update command in the [associations](https://elixirschool.com/en/lessons/ecto/associations/) lecture gives the following result (which -- unlike the lessons example -- contains "Wade Watts" and a distributor):

```elixir
iex(23)> Repo.update!(changeset)

19:02:04.751 [debug] QUERY OK db=0.4ms queue=0.1ms idle=1062.0ms
begin []
 
19:02:04.753 [debug] QUERY OK db=0.9ms
INSERT INTO "actors" ("name") VALUES ($1) RETURNING "id" ["Gary"]
 
19:02:04.757 [debug] QUERY OK db=2.4ms
INSERT INTO "movies_actors" ("actor_id","movie_id") VALUES ($1,$2) [6, 3]
 
19:02:04.769 [debug] QUERY OK db=11.6ms
commit []
%Friends.Movie{
  __meta__: #Ecto.Schema.Metadata<:loaded, "movies">,
  actors: [
    %Friends.Actor{
      __meta__: #Ecto.Schema.Metadata<:loaded, "actors">,
      id: 6,
      movies: #Ecto.Association.NotLoaded<association :movies is not loaded>,
      name: "Gary"
    }
  ], 
  characters: [
    %Friends.Character{
      __meta__: #Ecto.Schema.Metadata<:loaded, "characters">,
      id: 6,
      movie: #Ecto.Association.NotLoaded<association :movie is not loaded>,
      movie_id: 3,
      name: "Wade Watts"
    }
  ],
  distributor: %Friends.Distributor{
    __meta__: #Ecto.Schema.Metadata<:loaded, "distributors">,
    id: 4,
    movie: #Ecto.Association.NotLoaded<association :movie is not loaded>,
    movie_id: 3,
    name: "Netflix"
  },
  id: 3,
  tagline: "Something about video games",
  title: "Ready Player One"
}
```
