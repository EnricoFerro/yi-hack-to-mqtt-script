#!/bin/sh

YI_HACK_PREFIX="/home/yi-hack"
TMP_SD_YI_HACK_PREFIX="/tmp/sd/yi-hack"
PATH=$PATH:$YI_HACK_PREFIX/bin:$YI_HACK_PREFIX/usr/bin
CONF_HOMEASSISTANT_FILE="etc/homeassistant.conf"


$TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_adv_crond_hourly.sh
$TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_adv_crond_tenminutes.sh

if [ ! -f $YI_HACK_PREFIX/etc/homeassistant.conf ] ; then
    cp $TMP_SD_YI_HACK_PREFIX/$CONF_HOMEASSISTANT_FILE $YI_HACK_PREFIX/$CONF_HOMEASSISTANT_FILE
fi

ln -sf $TMP_SD_YI_HACK_PREFIX/www/pages/homeassistant.html $YI_HACK_PREFIX/www/pages/homeassistant.html
ln -sf $TMP_SD_YI_HACK_PREFIX/www/js/modules/homeassistant.js $YI_HACK_PREFIX/www/js/homeassistant.js


echo "0  *  *  *  *  /tmp/sd/yi-hack/script/homeassistant/mqtt_adv_crond_hourly.sh" >> /var/spool/cron/crontabs/root
echo "*/10  *  *  *  *  /tmp/sd/yi-hack/script/homeassistant/mqtt_adv_crond_tenminutes.sh" >> /var/spool/cron/crontabs/root


FW_VERSION=$(cat $YI_HACK_PREFIX/version)

if [ "$FW_VERSION" == "0.2.3" ] ; then
    $TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_set_config.0.2.3.sh &
else
    $TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_set_config.sh &
fi
