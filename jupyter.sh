#!/bin/sh

# Create network...ok if this fails.
if ! $(docker network create arrow-net > /dev/null 2>&1); then
        echo "arrow-net network already exists."
else
        echo "arrow-net network created."
fi

# Launch Jupyterlabs in Docker
docker run --rm -it \
	-p 8888:8888 \
	--name "jupyter" \
	--hostname "jupyter.arrow" \
	--network "arrow-net" \
	--user "$(id -u):$(id -g)" \
	--mount "type=bind,source=$(pwd)/notebooks,target=/home/jovyan/work" \
	--mount "type=bind,source=$(pwd)/input,target=/home/jovyan/input,readonly" \
	jupyter/base-notebook:python-3.10.6
	
