#!/bin/sh

YI_HACK_PREFIX="/home/yi-hack"
TMP_SD_YI_HACK_PREFIX="/tmp/sd/yi-hack/script/homeassistant"

FW_VERSION=$(cat $YI_HACK_PREFIX/version)

if [ "$FW_VERSION" == "0.2.3" ] ; then
    $TMP_SD_YI_HACK_PREFIX/mqtt_adv_homeassistant.0.2.3.sh &
elif [ "$FW_VERSION" == "0.2.2" ] ; then
    $TMP_SD_YI_HACK_PREFIX/mqtt_adv_homeassistant.0.2.0.sh &
elif [ "$FW_VERSION" == "0.2.1" ] ; then
    $TMP_SD_YI_HACK_PREFIX/mqtt_adv_homeassistant.0.2.0.sh &
elif [ "$FW_VERSION" == "0.2.0" ] ; then
    $TMP_SD_YI_HACK_PREFIX/mqtt_adv_homeassistant.0.2.0.sh &
elif [ "$FW_VERSION" == "0.1.9" ] ; then
    $TMP_SD_YI_HACK_PREFIX/mqtt_adv_homeassistant.0.1.9.sh &
else
    $TMP_SD_YI_HACK_PREFIX/mqtt_adv_homeassistant.0.1.8.sh &
fi