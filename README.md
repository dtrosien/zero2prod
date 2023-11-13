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


### test curls
curl -v http://127.0.0.1:8000/health_check

curl --request POST \
--data 'name=test&email=test%40gmail.com' \
127.0.0.1:8000/subscriptions --verbose


### Deploy on Digital Ocean:
Create Token at https://cloud.digitalocean.com/account/api/tokens (with write rights)
Authenticate:

    doctl auth init 

Deploy App:

    doctl apps create --spec spec.yaml 

Check Apps:

    doctl apps list 


migrate cloud db (might require disabling trusted sources temporarily https://docs.digitalocean.com/products/databases/postgresql/how-to/secure/):

    DATABASE_URL=YOUR-DIGITAL-OCEAN-DB-CONNECTION-STRING sqlx migrate run
