import Config

config :friends, Friends.Repo,
  database: "friends_repo",
  username: "someuser",
  password: "somepassword",
  hostname: "localhost"

config :friends, ecto_repos: [Friends.Repo]

