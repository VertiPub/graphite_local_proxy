# -*- mode: shell -*-

# this is our default graphite rabbitmq service.
# normally this will be replaced with a config that
# points to the colo local graphite rabbitmq service.
export AMQP_HOST="rabbitmq.vip.replace_me.com"
# for testing
#export AMQP_HOST="localhost"
export AMQP_PORT="5672"

export AMQP_HOSTPORT=${AMQP_HOST}:${AMQP_PORT}

export AMQP_VHOST="/graphite"
export AMQP_EXCHANGE="metrics"
export AMQP_GRAPHITE_EXCHANGE="metrics"

export AMQP_LOGS_EXCHANGE="logs"

export AMQP_USER="graphite"
export AMQP_PASSWORD="graphite"

export LOG_CONFIG="/etc/graphite/graphite_local_proxy_log.conf"

# local TCP port to listen on, similar to carbon-cache agent.
export LOCAL_PORT="2003"

# unlikely we'll change from localhost for a local proxy. but it's there.
export LOCAL_HOST="127.0.0.1"

# while the amqp server is down, keep a backlog queue of max size:
export MAX_BACKLOG_SIZE="1000000"
