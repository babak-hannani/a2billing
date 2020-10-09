#!/bin/sh
set -e

ln -s /usr/local/src/a2billing/a2billing.conf /etc/a2billing.conf && \
chmod 777 /etc/asterisk && \
touch /etc/asterisk/additional_a2billing_iax.conf && \
touch /etc/asterisk/additional_a2billing_sip.conf && \
echo \#include additional_a2billing_sip.conf >> /etc/asterisk/sip.conf && \
echo \#include additional_a2billing_iax.conf >> /etc/asterisk/iax.conf && \
chown -Rf www-data /etc/asterisk/additional_a2billing_iax.conf && \
chown -Rf www-data /etc/asterisk/additional_a2billing_sip.conf

/usr/local/src/a2billing/addons/install_a2b_sounds_deb.sh
chown -R asterisk:asterisk /usr/share/asterisk/sounds/

echo "
[general]
enabled = yes
port = 5038
bindaddr = 0.0.0.0

[myasterisk]
secret=mycode
read=system,call,log,verbose,command,agent,user
write=system,call,log,verbose,command,agent,user" > /etc/asterisk/manager.conf

mkdir /usr/share/asterisk/agi-bin
chown asterisk:asterisk /usr/share/asterisk/agi-bin

ln -s /usr/local/src/a2billing/AGI/a2billing.php /usr/share/asterisk/agi-bin/a2billing.php
ln -s /usr/local/src/a2billing/AGI/lib /usr/share/asterisk/agi-bin/lib

chmod +x /usr/share/asterisk/agi-bin/a2billing.php
chmod +x /usr/share/asterisk/agi-bin/a2billing_monitoring.php

mkdir /var/www/a2billing
chown www-data:www-data /var/www/a2billing
mkdir -p /var/lib/a2billing/script
mkdir -p /var/run/a2billing

ln -s /usr/local/src/a2billing/admin /var/www/a2billing/admin
ln -s /usr/local/src/a2billing/agent /var/www/a2billing/agent
ln -s /usr/local/src/a2billing/customer /var/www/a2billing/customer
ln -s /usr/local/src/a2billing/common /var/www/a2billing/common

chmod 755 /usr/local/src/a2billing/admin/templates_c
chmod 755 /usr/local/src/a2billing/customer/templates_c
chmod 755 /usr/local/src/a2billing/agent/templates_c
chown -Rf www-data:www-data /usr/local/src/a2billing/admin/templates_c
chown -Rf www-data:www-data /usr/local/src/a2billing/customer/templates_c
chown -Rf www-data:www-data /usr/local/src/a2billing/agent/templates_c

echo "
[a2billing]
include => a2billing_callingcard
include => a2billing_monitoring
include => a2billing_voucher

[a2billing_callingcard]
; CallingCard application
exten => _X.,1,NoOp(A2Billing Start)
exten => _X.,n,DeadAgi(a2billing.php|1)
exten => _X.,n,Hangup

[a2billing_voucher]
exten => _X.,1,Answer(1)
exten => _X.,n,DeadAgi(a2billing.php|1|voucher)
;exten => _X.,n,AGI(a2billing.php|1|voucher44) ; will add 44 in front of the callerID for the CID authentication
exten => _X.,n,Hangup

[a2billing_did]
exten => _X.,1,DeadAgi(a2billing.php|1|did)
exten => _X.,2,Hangup" > /etc/asterisk/extensions.conf

cp /usr/local/src/a2billing/CallBack/callback-daemon-py/callback_daemon/a2b-callback-daemon.debian  /etc/init.d/a2b-callback-daemon
chmod +x /etc/init.d/a2b-callback-daemon

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
    set -- apache2-foreground "$@"
fi
exec "$@"
