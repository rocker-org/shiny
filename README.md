Docker for Shiny Server
=======================

This is a Dockerfile for Shiny Server on Debian stable.  Dockerfiles building on specific versions of R are now available as tags.  These images are based on the corresponding [r-ver](https://hub.docker.com/rocker/r-ver) image.  You can request a specific R version using the appropriate tag, e.g. `rocker/shiny:3.3.2`.    


The images are available from [Docker Hub](https://registry.hub.docker.com/u/rocker/shiny/).






## Usage:

### With docker

To run a temporary container with Shiny Server:

```sh
docker run --rm -p 3838:3838 rocker/shiny
```

To expose a directory on the host to the container, use `-v <host_dir>:<container_dir>`. The following command will use one `/srv/shinyapps` as the Shiny app directory and `/srv/shinylog` as the directory for Shiny app logs. Note that if the directories on the host don't already exist, they will be created automatically.:

```sh
docker run --rm -p 3838:3838 \
    -v /srv/shinyapps/:/srv/shiny-server/ \
    -v /srv/shinylog/:/var/log/shiny-server/ \
    rocker/shiny
```

If you have an app in `/srv/shinyapps/appdir`, you can run the app by visiting http://localhost:3838/appdir/. (If using boot2docker, visit http://192.168.59.103:3838/appdir/)

In a real deployment scenario, you will probably want to run the container in detached mode (`-d`) and listening on the host's port 80 (`-p 80:3838`):

```sh
docker run -d -p 80:3838 \
    -v /srv/shinyapps/:/srv/shiny-server/ \
    -v /srv/shinylog/:/var/log/shiny-server/ \
    rocker/shiny
```

### Warnings

In the logs, you may see a note that shiny is running as root.  To run as a regular user, simply set the user in your Docker run command, e.g.

```sh
docker run --user shiny -p 3838:3838 --rm rocker/shiny
```


### Logs

As of January 2017, the Shiny Server log is written to `stdout` and can be viewed using `docker logs`. The logs for individual apps are in the `/var/log/shiny-server` directory, as described in the [Shiny Server Administrator's Guide]( http://docs.rstudio.com/shiny-server/#application-error-logs)

### With docker-compose

This repository includes an example `docker-compose` file, to facilitate using this container within docker networks.

#### To run a container with Shiny Server:

```sh
docker-compose up
```

Then visit `http://localhost` (i.e., `http://localhost:80`) in a web browser. If you have an app in `/srv/shinyapps/appdir`, you can run the app by visiting http://localhost/appdir/.

#### To add a Shiny app:

1. Uncomment the last line of `docker-compose.yml`.
1. Place the app in `mountpoints/apps/the-name-of-the-app`, replacing `the-name-of-the-app` with your app's name.

If you have an app in `mountpoints/apps/appdir`, you can run the app by visiting http://localhost/appdir/. (If using boot2docker, visit http://192.168.59.103:3838/appdir/)

#### Logs

The example `docker-compose` file will create a persistent volume for server logs, so that log data will persist across instances where the container is running. To access these logs, while the container is running, run `docker exec -it shiny bash` and then `ls /var/log/shiny-server` to see the available logs. To copy these logs to the host system for inspection, while the container is running, you can use, for example, `docker cp shiny:/var/log/shiny-server ./logs_for_inspection`.

#### Push all aplication logs to STDOUT

> This is experimental feature. Use it on your own risk!

Original shiny-server does not have an option to push all the logs to STDOUT, however the Docker best practices highly recommend that.

However, technically, there is a workaround to listen to filesystem events in the logs folder and push them to STDOUT.

To enable this mode set `APPLICATION_LOGS_TO_STDOUT` to `true`.

```sh
docker run -it -e APPLICATION_LOGS_TO_STDOUT=true -p 3838:3838 shiny-local
```

#### Detached mode

In a real deployment scenario, you will probably want to run the container in detached mode (`-d`):

```sh
docker-compose up -d
```

### Custom configuration

To add a custom configuration file, assuming the custom file is called `shiny-customized.config`, uncomment the line

```
COPY shiny-customized.config /etc/shiny-server/shiny-server.conf
```

in the `Dockerfile`, and then run `docker-compose build shiny` to rebuild the container. Inline comments above that line in the `Dockerfile` provide additional documentation.

## Trademarks

Shiny and Shiny Server are registered trademarks of RStudio, Inc. The use of the trademarked terms Shiny and Shiny Server and the distribution of the Shiny Server through the images hosted on hub.docker.com has been granted by explicit permission of RStudio. Please review RStudio's trademark use policy and address inquiries about further distribution or other questions to permissions@rstudio.com.
