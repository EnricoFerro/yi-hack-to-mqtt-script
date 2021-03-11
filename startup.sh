#!/bin/sh

YI_HACK_PREFIX="/home/yi-hack"
TMP_SD_YI_HACK_PREFIX="/tmp/sd/yi-hack"

if [ ! -f $YI_HACK_PREFIX/$CONF_MQTT_ADVERTISE_FILE ]; then
    cp $TMP_SD_YI_HACK_PREFIX/$CONF_MQTT_ADVERTISE_FILE $YI_HACK_PREFIX/$CONF_MQTT_ADVERTISE_FILE
fi

ln -sf $TMP_SD_YI_HACK_PREFIX/www/pages/mqtt_adv.html $YI_HACK_PREFIX/www/pages/mqtt_adv.html
ln -sf $TMP_SD_YI_HACK_PREFIX/www/js/modules/mqtt_adv.js $YI_HACK_PREFIX/www/js/mqtt_adv.js
ln -sf $TMP_SD_YI_HACK_PREFIX/script/mqtt_advertise $YI_HACK_PREFIX/script/mqtt_advertise

if [ -f "$YI_HACK_PREFIX/script/mqtt_advertise/startup.sh" ]; then   
    $YI_HACK_PREFIX/script/mqtt_advertise/startup.sh                 
fi                                             
