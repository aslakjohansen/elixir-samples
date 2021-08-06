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
