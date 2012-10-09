PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
OUTLOG=/var/log/admob/logs/graphite_local_proxy_cron
# checking that the graphite_local_proxy is running every 5 minutes.
*/5 * * * * root ( /var/lib/graphite_local_proxy/graphite_local_proxy_cron_check >> $OUTLOG 2>&1 )
# NOTE: we're appending to the logfile.  should add a logrotate rule here.
