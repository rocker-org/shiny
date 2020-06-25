Docker for Shiny Server
=======================

![](https://img.shields.io/docker/build/rocker/shiny.svg) ![](https://img.shields.io/docker/build/rocker/shiny-verse.svg)

This is a Dockerfile for Shiny Server on Debian stable.  Dockerfiles building on specific versions of R are now available as tags.  These images are based on the corresponding [r-ver](https://hub.docker.com/r/rocker/r-ver) image.  You can request a specific R version using the appropriate tag, e.g. `rocker/shiny:3.3.2`.    

***For documentation for R >= 4.0.0, for images `r-ver`, `rstudio`, `tidyverse`, `verse`, `geospatial`, `shiny`, and `binder`, please see the [`rocker-versioned2` repository`](https://github.com/rocker-org/rocker-versioned2).*** 


## Usage:


To run a temporary container with Shiny Server:

```sh
docker run --rm -p 3838:3838 rocker/shiny
```

To get specific version of R with your shiny image (e.g. 3.4.4):


```sh
docker run --rm -p 3838:3838 rocker/shiny:3.4.4
```

### Developer Notes

- **avoid `apt-get install r-cran-*`** on this image stack.  The requested R version and all R packages are installed from source in the version-stable stack.  Installing R packages from `apt` (e.g. the `r-cran-*` packages) will install the version of R and versions of the packages that were built for the stable debian release (e.g. `debian:stretch`), giving you a second version of R and different packages.  Please install R packages from source using the `install.packages()` R function (or the `install2.r` script), and use `apt` only to install necessary system libraries (e.g. `libxml2`). If you would prefer to install only the latest verions of packages from pre-built binaries using `apt-get`, consider using the `r-base` stack instead.  See [rocker-versioned README](https://github.com/rocker-org/rocker-versioned) for details on extending these images. 

### shiny-verse

You can use `rocker/shiny-verse` image stack instead if you'd like `tidyverse` packages pre-installed on your instance of shiny.  

### Connecting app and log directories to host

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

The Shiny Server log and all application logs are written to `stdout` and can be viewed using `docker logs`.

The logs for individual apps are still kept in the `/var/log/shiny-server` directory, as described in the [Shiny Server Administrator's Guide]( http://docs.rstudio.com/shiny-server/#application-error-logs). If you want to avoid printing the logs to STDOUT, set up the environment variable `APPLICATION_LOGS_TO_STDOUT` to `false` (`-e APPLICATION_LOGS_TO_STDOUT=false`).


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
