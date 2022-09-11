# Feast Deployment using Docker Compose
Easily deploy a Feast Feature Store for feature tracking.
Registry and data sources are stored inside MiniO.
Redis is used as online store and MiniO is used as offline store.


Build and run the containers with `make start`

Other commands:
    `make build` - only builds feast ui docker image
    `make apply` - executes `feast apply` inside docker container 
    `make materialize` - executes `feast materialize-incremental $<current time>` inside docker container 
        (Loads all features available from start time to current time into online store.)
    `make serve` - runs feast container serving web ui


Access Feast UI with http://localhost:3378

