#! /bin/sh
#set -x 
### BEGIN INIT INFO
# Provides:          graphite_local_proxy
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: graphite local metrics proxy
# Description:       graphite local metrics proxy reads from named pipe and forwards to rabbitMQ.
### END INIT INFO

# Author: Allan Bailey <abailey@admob.com>
#
# Do NOT "set -e"

# PATH should only include /usr/* if it runs after the mountnfs.sh script
PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC="graphite local metrics proxy"
NAME=graphite_local_proxy
DAEMON=/usr/sbin/$NAME
DAEMON_ARGS=""
PIDFILE=/var/run/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME

# Exit if the package is not installed
[ -x "$DAEMON" ] || exit 0

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

# Load the VERBOSE setting and other rcS variables
. /lib/init/vars.sh

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.0-6) to ensure that this file is present.
. /lib/lsb/init-functions

#
# Function that starts the daemon/service
#
do_start()
{
        if [ -e $PIDFILE ]; then
	    p=`cat $PIDFILE`
	    if [ ! -z "$p" -a -e "/proc/$p" ]; then
		log_daemon_msg " ERROR: $PIDFILE exists and process still running. exiting."
		return 1
	    else
		/bin/rm -f $PIDFILE
	    fi
	fi
	#$DAEMON
	# This is oogly, but it works.
	($DAEMON > /dev/null 2> /dev/null < /dev/null & ) &
	echo
}

#
# Function that stops the daemon/service
#
do_stop()
{
    if [ -e $PIDFILE ]; then
	pid=`cat $PIDFILE`
    fi
    [ -z "$pid" ] && return 0
    ps -p $pid > /dev/null && /bin/kill $pid
    sleep 1 # be nice.
    ps -p $pid > /dev/null && /bin/kill -9 $pid
    rm -f $PIDFILE
}


case "$1" in
  start)
	log_daemon_msg "Starting $DESC" "$NAME"
	do_start
	;;
  stop)
	log_daemon_msg "Stopping $DESC" "$NAME"
	do_stop
	;;
  restart|force-reload)
	log_daemon_msg "Restarting $DESC" "$NAME"
	do_stop
	do_start
	;;
  *)
	echo "Usage: $SCRIPTNAME {start|stop|restart|force-reload}" >&2
	exit 3
	;;
esac

#:
exit 0
