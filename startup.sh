#!/bin/sh

YI_HACK_PREFIX="/home/yi-hack"
TMP_SD_YI_HACK_PREFIX="/tmp/sd/yi-hack"
PATH=$PATH:$YI_HACK_PREFIX/bin:$YI_HACK_PREFIX/usr/bin
CONF_HOMEASSISTANT_FILE="etc/homeassistant.conf"

if [ ! -f $YI_HACK_PREFIX/etc/homeassistant.conf ]; then
    cp $TMP_SD_YI_HACK_PREFIX/$CONF_HOMEASSISTANT_FILE $YI_HACK_PREFIX/$CONF_HOMEASSISTANT_FILE
fi

ln -sf $TMP_SD_YI_HACK_PREFIX/www/pages/homeassistant.html $YI_HACK_PREFIX/www/pages/homeassistant.html
ln -sf $TMP_SD_YI_HACK_PREFIX/www/js/modules/homeassistant.js $YI_HACK_PREFIX/www/js/homeassistant.js

get_homeassistant_config() {
    key=$1
    grep -w $1 $YI_HACK_PREFIX/$CONF_HOMEASSISTANT_FILE | cut -d "=" -f2
}

MQTT_ADV_INFO_GLOBAL_ENABLE=$(get_homeassistant_config MQTT_ADV_INFO_GLOBAL_ENABLE)
MQTT_ADV_INFO_GLOBAL_BOOT=$(get_homeassistant_config MQTT_ADV_INFO_GLOBAL_BOOT)
MQTT_ADV_INFO_GLOBAL_CRON=$(get_homeassistant_config MQTT_ADV_INFO_GLOBAL_CRON)
MQTT_ADV_INFO_GLOBAL_CRONTAB=$(get_homeassistant_config MQTT_ADV_INFO_GLOBAL_CRONTAB)
HOMEASSISTANT_ENABLE=$(get_homeassistant_config HOMEASSISTANT_ENABLE)
HOMEASSISTANT_BOOT=$(get_homeassistant_config HOMEASSISTANT_BOOT)
HOMEASSISTANT_CRON=$(get_homeassistant_config HOMEASSISTANT_CRON)
HOMEASSISTANT_CRONTAB=$(get_homeassistant_config HOMEASSISTANT_CRONTAB)

$TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_adv_crond_hourly.sh
$TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_adv_crond_tenminutes.sh

if [ "$MQTT_ADV_INFO_GLOBAL_ENABLE" == "yes" ]; then
    if [ "$MQTT_ADV_INFO_GLOBAL_BOOT" == "yes" ]; then
        $TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_adv_info_global.sh
    fi
    if [ "$MQTT_ADV_INFO_GLOBAL_CRON" == "yes" ]; then
        echo "$MQTT_ADV_INFO_GLOBAL_CRONTAB  $TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_adv_info_global.sh" >>/var/spool/cron/crontabs/root
    fi
fi
if [ "$HOMEASSISTANT_ENABLE" == "yes" ]; then
    if [ "$HOMEASSISTANT_BOOT" == "yes" ]; then
        $TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_adv_homeassistant.sh
    fi
    if [ "$HOMEASSISTANT_CRON" == "yes" ]; then
        echo "$HOMEASSISTANT_CRONTAB  $TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_adv_homeassistant.sh" >>/var/spool/cron/crontabs/root
    fi
fi

echo "0  *  *  *  *  /tmp/sd/yi-hack/script/homeassistant/mqtt_adv_crond_hourly.sh" >>/var/spool/cron/crontabs/root
echo "*/10  *  *  *  *  /tmp/sd/yi-hack/script/homeassistant/mqtt_adv_crond_tenminutes.sh" >>/var/spool/cron/crontabs/root

FW_VERSION=$(cat $YI_HACK_PREFIX/version)

if [ "$FW_VERSION" == "0.2.3" ]; then
    $TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_set_config.0.2.3.sh &
else
    $TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_set_config.sh &
fi
