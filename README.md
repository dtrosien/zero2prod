# zero2prod

email newsletter: a training project

### structure

* .env:  contains db information needed for compiling sqlx:
    * sqlx reaches out to Postgres at compile-time to check that queries are well-formed. Just like sqlx-cli commands,
      it relies on the DATABASE_URL environment variable to know where to find the database.
    * sqlx will read DATABASE_URL from it and save us the hassle of re-exporting the environment variable every single
      time.
    * this is only needed for compiling, during runtime the configuration.yaml is used to change the db connection

### todo

* docker caching
* expiry mechanism for idempotency keys (as background job like issue workers)

### test curls

curl -v http://127.0.0.1:8000/health_check

curl --request POST \
--data 'name=test&email=test%40gmail.com' \
127.0.0.1:8000/subscriptions --verbose

### Prepare sqlx meta for offline mode

To create a json file in .sqlx which will be used in offline mode (needed to build docker) to check the queries, run:

    cargo sqlx prepare -- --tests

The created file needs to be checked into git. (If you just get one file with the database in it, then something went
wrong.)

### test commands

for log output in tests use following env and for formatting pipe into bunyan

    export TEST_LOG=true

    cargo t subscribe_fails_if_there_is_a_fatal_database_error | bunyan

### Deploy on Digital Ocean:

Create Token at https://cloud.digitalocean.com/account/api/tokens (with write rights)
Authenticate:

    doctl auth init 

Deploy App:

    doctl apps create --spec spec.yaml 

Check Apps:

    doctl apps list 

migrate cloud db (might require disabling trusted sources
temporarily https://docs.digitalocean.com/products/databases/postgresql/how-to/secure/):

    DATABASE_URL=YOUR-DIGITAL-OCEAN-DB-CONNECTION-STRING sqlx migrate run

Redis must be deployed manually (not supported via spec.yaml):
https://cloud.digitalocean.com/databases/new?engine=redis&i=83b9b8

The connection string to the Redis instance will be injected into the application using an environment value

- set APP_REDIS_URI from the Settings panel in the application console.

The `APP_APPLICATION__HMAC_SECRET` environment variable needs to be set on Digital Ocean as well for production

### initial admin

* user: admin
* pw: everythinghastostartsomewhere

### issue when running local:

https://github.com/LukeMathWalker/zero-to-production/issues/234#issuecomment-1825106004
(fixed with additional cookie setting)



