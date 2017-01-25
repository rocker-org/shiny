Docker for Shiny Server
=======================

This is a Dockerfile for Shiny Server on Debian "testing". It is based on the r-base image.

The image is available from [Docker Hub](https://registry.hub.docker.com/u/rocker/shiny/).

As of January 2017, the Shiny Server log is written to `stdout` and can be viewed using `docker logs`. The logs for individual apps are in the `/var/log/shiny-server` directory, as described in the [Shiny Server Administrator's Guide]( http://docs.rstudio.com/shiny-server/#application-error-logs)

## Usage:

To run a temporary container with Shiny Server:

```sh
docker run --rm -p 3838:3838 rocker/shiny
```


To expose a directory on the host to the container use `-v <host_dir>:<container_dir>`. The following command will use one `/srv/shinyapps` as the Shiny app directory and `/srv/shinylog` as the directory for Shiny app logs. Note that if the directories on the host don't already exist, they will be created automatically.:

```sh
docker run --rm -p 3838:3838 \
    -v /srv/shinyapps/:/srv/shiny-server/ \
    -v /srv/shinylog/:/var/log/shiny-server/ \
    rocker/shiny
```

If you have an app in /srv/shinyapps/appdir, you can run the app by visiting http://localhost:3838/appdir/. (If using boot2docker, visit http://192.168.59.103:3838/appdir/)


In a real deployment scenario, you will probably want to run the container in detached mode (`-d`) and listening on the host's port 80 (`-p 80:3838`):

```sh
docker run -d -p 80:3838 \
    -v /srv/shinyapps/:/srv/shiny-server/ \
    -v /srv/shinylog/:/var/log/shiny-server/ \
    rocker/shiny
```


## Trademarks

Shiny and Shiny Server are registered trademarks of RStudio, Inc. The use of the trademarked terms Shiny and Shiny Server and the distribution of the Shiny Server through the images hosted on hub.docker.com has been granted by explicit permission of RStudio. Please review RStudio's trademark use policy and address inquiries about further distribution or other questions to permissions@rstudio.com.
