#!/bin/bash

mysql -u root -p"a2billing" < /a2billing-mysql-5.x/a2billing-MYSQL-createdb-user.sql 

### Use for Open sessin of Container
#if [ "$1" != "" ]; then
#    echo "** Executing '$@'"
#    exec "$@"
#elif [ -f "/usr/bin/supervisord" ]; then
#    echo "** Executing supervisord"
#    exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
#else
#    echo "Unknown instructions. Exiting..."
#    exit 1
#fi
