
This is a generic version of a local proxy being used at AdMob.com
for sending metrics from hosts to the local graphite rabbitmq service.
We use carbon-cache agent to pull only from the rabbitmq service, and
this localhost proxy enables us to scale the graphite service more
easily.
