This is the result of following this [guide](https://www.youtube.com/watch?v=xgz-HTot3R8).

Install Postgres (on Ubuntu):

```shell
sudo apt-get install postgresql postgresql-contrib libpq-dev
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"
sudo service postgresql restart
```

Boilerplate code generated by:

```shell
mix phx.new live_view_todos --live
```

Setup database:

```shell
cd live_view_todos
mix ecto.setup
```

Run Phoenix server to see it working:

```shell
mix phx.server
```

Exit it and create migration, schema and context(s?) (`Todos` is ?, `Todo` is ?, `todos` is the table name, and the latter two are the columns for the table):

```shell
mix phx.gen.context Todos Todo todos title:string done:boolean
```

Create/setup (or migrate) database:

```shell
mix ecto.migrate
```


