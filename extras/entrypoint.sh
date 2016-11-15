#!/bin/sh
set -e

# Warn if the DOCKER_HOST socket does not exist
if [[ ! -z $DOCKER_HOST ]]; then
	socket_file=${DOCKER_HOST#unix://}
	if ! [ -S $socket_file ]; then
		cat >&2 <<-EOT
			ERROR: you need to share your Docker host socket with a volume at $socket_file
			Typically you should run your mgvazquez/snmp-proxy with: \`-v /var/run/docker.sock:$socket_file:ro\`
		EOT
		socketMissing=1
	fi
fi

# If the user has run the default command and the socket doesn't exist, fail
if [ "$socketMissing" = 1 -a "$1" = supervisord ]; then
	exit 1
fi

exec "$@"
