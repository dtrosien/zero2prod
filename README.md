# zero2prod

email newsletter: a training project

### structure
* .env:  contains db information needed for compiling sqlx:
  * sqlx reaches out to Postgres at compile-time to check that queries are well-formed. Just like sqlx-cli commands, it relies on the DATABASE_URL environment variable to know where to find the database.
  * sqlx will read DATABASE_URL from it and save us the hassle of re-exporting the environment variable every single time.
  * this is only needed for compiling, during runtime the configuration.yaml is used to change the db connection

### todo

docker caching
link github account with digital ocean


