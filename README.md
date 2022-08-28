# Feast Deployment using Docker Compose
Easily deploy a Feast Feature Store for feature tracking.
Registry and data sources are stored inside MiniO.


Build and run the containers with `make start`

Other commands:
    `make build` - only builds feast ui docker image
    `make apply` - executes `feast apply` inside docker container 
    `make serve` - runs feast container serving web ui


Access Feast UI with http://localhost:3378

