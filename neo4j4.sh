#!/bin/sh
HEAP="3g"
HOST="neo4j.arrow"

# Create network...ok if this fails.
if ! $(docker network create arrow-net > /dev/null 2>&1); then
	echo "arrow-net network already exists."
else
	echo "arrow-net network created."
fi

# Run our Neo4j container
docker run --rm -it \
	--name "arrow-field-training" \
	--hostname "${HOST}" \
	--network "arrow-net" \
	-p 7474:7474 -p 7687:7687 -p 8491:8491 \
	--env "NEO4J_ACCEPT_LICENSE_AGREEMENT=yes" \
	--env "NEO4J_AUTH=neo4j/password" \
	--env "NEO4J_dbms_memory_pagecache_size=1g" \
	--env "NEO4J_dbms_memory_heap_max__size=${HEAP}" \
	--env "NEO4J_dbms_security_procedures_unrestricted=gds.*" \
	--env "NEO4J_dbms_security_procedures_allowlist=gds.*" \
	--env "NEO4J_gds_arrow_enabled=true" \
	--env "NEO4J_gds_arrow_listen__address=${HOST}:8491" \
	--env "NEO4J_gds_enterprise_license__file=/licenses/gds.license" \
	--mount "type=bind,source=$(pwd)/plugins,target=/plugins,readonly" \
	--mount "type=bind,source=$(pwd)/licenses,target=/licenses,readonly" \
	--mount "type=tmpfs,destination=/data" \
	neo4j:4.4-enterprise
