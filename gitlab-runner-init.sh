#! /bin/bash

### BEGIN INIT INFO
# Provides:          /usr/local/bin/gitlab-ci-multi-runner
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: gitlab-runner
# Description:       GitLab Runner
### END INIT INFO

DESC="GitLab Runner"
USER=""
NAME="gitlab-runner"
PIDFILE="/var/run/$NAME.pid"

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

# Define LSB log_* functions.
. /lib/lsb/init-functions

## Check to see if we are running as root first.
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root"
    exit 1
fi

do_start() {
  start-stop-daemon --start \
     \
     \
     \
    --pidfile "$PIDFILE" \
    --background \
    --make-pidfile \
    --exec /usr/local/bin/gitlab-ci-multi-runner --  "run" "--working-directory" "/data/services" "--config" "/etc/gitlab-runner/config.toml" "--service" "gitlab-runner" "--syslog" "--user" "root"
}

do_stop() {
  start-stop-daemon --stop \
     \
    --pidfile "$PIDFILE" \
    --quiet
}

case "$1" in
  start)
    log_daemon_msg "Starting $DESC"
    do_start
    log_end_msg $?
    ;;
  stop)
    log_daemon_msg "Stopping $DESC"
    do_stop
    log_end_msg $?
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  status)
    status_of_proc -p "$PIDFILE" "$DAEMON" "$DESC"
    ;;
  *)
    echo "Usage: sudo service $0 {start|stop|restart|status}" >&2
    exit 1
    ;;
esac

exit 0
