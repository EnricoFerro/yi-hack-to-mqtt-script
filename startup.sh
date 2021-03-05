#!/bin/sh

YI_HACK_PREFIX="/home/yi-hack"
TMP_SD_YI_HACK_PREFIX="/tmp/sd/yi-hack"
PATH=$PATH:$YI_HACK_PREFIX/bin:$YI_HACK_PREFIX/usr/bin



$TMP_SD_YI_HACK_PREFIX/mqtt_crond_hourly.sh
$TMP_SD_YI_HACK_PREFIX/mqtt_crond_tenminutes.sh


if [ ! -f "/var/spool/cron/crontabs/root" ]; then
    mkdir -p /var/spool/cron/crontabs/
fi
killall -q crond
echo "  0  *  *  *  *  /tmp/sd/yi-hack/mqtt_crond_hourly.sh" >> /var/spool/cron/crontabs/root
echo "  */10  *  *  *  *  /tmp/sd/yi-hack/mqtt_crond_tenminutes.sh" >> /var/spool/cron/crontabs/root
$YI_HACK_PREFIX/usr/sbin/crond -c /var/spool/cron/crontabs/

$TMP_SD_YI_HACK_PREFIX/mqtt_config_set.sh &
