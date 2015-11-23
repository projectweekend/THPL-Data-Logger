THPL Data Logger
====================

This project subscribes to messages published by [Pi-THPL-Data-Reporter](https://github.com/projectweekend/Pi-THPL-Data-Reporter) and logs the data in a Postgres database.


Environment Variables
====================

The following environment variables are used:

* `DATABASE_URL` - Postgres database connection URL
* `PICLOUD_URL` - URL for the [picloud](https://github.com/exitcodezero/picloud) server
* `PICLOUD_API_KEY` - API key for the picloud server


Database Migrations
====================

Database migrations are handled by [Flyway](http://flywaydb.org/) and files are stored in the `/sql` directory. You can run migrations manually in the development environment using `docker-compose`. The included script `local_migrate.sh` uses an environment variable created by [Docker Compose](https://docs.docker.com/compose/env/) to find the IP address assigned to the database and execute the Flyway command to run migrations.

```
docker-compose run flyway ./local_migrate.sh
```


Run Locally
====================

The development environment for this project uses [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/). With those tools installed and database migrations applied, run the following to start it locally:

```
docker-compose up
```
