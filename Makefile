latest:
	docker build -t rocker/shiny .

sync:
	echo 3.* devel | xargs -n 1 cp shiny-server.sh


3.3.2: .PHONY
	export R_VERSION=3.3.2 && make update

3.3.1: .PHONY
	export R_VERSION=3.3.1 && make update

update:
	cp Dockerfile ${R_VERSION}/Dockerfile
	cp shiny-server.sh ${R_VERSION}/shiny-server.sh
	sed 's/r-ver:latest/r-ver:${R_VERSION}/' < ${R_VERSION}/Dockerfile > ${R_VERSION}/tmp
	mv ${R_VERSION}/tmp ${R_VERSION}/Dockerfile # bc sed -i fails on mac

build:
	docker build -t rocker/shiny:${R_VERSION} ${R_VERSION}


.PHONY:
	echo "Syncing rstudio images...\n"

