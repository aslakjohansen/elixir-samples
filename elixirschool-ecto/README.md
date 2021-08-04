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

