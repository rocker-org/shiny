Docker for Shiny Server
=======================

This is a Dockerfile for Shiny Server on Debian "testing". It is based on the r-base image.

The image is available from [Docker Hub](https://registry.hub.docker.com/u/rocker/shiny/).

As of January 2017, the Shiny Server log is written to `stdout` and can be viewed using `docker logs`. The logs for individual apps are in the `/var/log/shiny-server` directory, as described in the [Shiny Server Administrator's Guide]( http://docs.rstudio.com/shiny-server/#application-error-logs)

## Usage:

To run a temporary container with Shiny Server:

```sh
docker-compose up
```

Then visit `http://localhost` (i.e., `http://localhost:80`) in a web browser.

To add a Shiny app:

1. Uncomment the last line of `docker-compose.yml`.
1. Place the app in `mountpoints/apps/the-name-of-the-app`, replacing `the-name-of-the-app` with your app's name.

If you have an app in `mountpoints/apps/appdir`, you can run the app by visiting http://localhost/appdir/. (If using boot2docker, visit http://192.168.59.103:3838/appdir/)

In a real deployment scenario, you will probably want to run the container in detached mode (`-d`):

```sh
docker-compose up -d
```


## Trademarks

Shiny and Shiny Server are registered trademarks of RStudio, Inc. The use of the trademarked terms Shiny and Shiny Server and the distribution of the Shiny Server through the images hosted on hub.docker.com has been granted by explicit permission of RStudio. Please review RStudio's trademark use policy and address inquiries about further distribution or other questions to permissions@rstudio.com.
