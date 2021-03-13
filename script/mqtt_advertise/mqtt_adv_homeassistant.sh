#!/bin/sh

YI_HACK_PREFIX="/home/yi-hack"
SCRIPT_HOMEASSISTANT="$YI_HACK_PREFIX/script/mqtt_advertise"

FW_VERSION=$(cat $YI_HACK_PREFIX/version)

if [ "$FW_VERSION" == "0.2.3" ]; then
    $SCRIPT_HOMEASSISTANT/mqtt_adv_homeassistant.0.2.3.sh &
elif [ "$FW_VERSION" == "0.2.2" ]; then
    $SCRIPT_HOMEASSISTANT/mqtt_adv_homeassistant.0.2.1.sh &
elif [ "$FW_VERSION" == "0.2.1" ]; then
    $SCRIPT_HOMEASSISTANT/mqtt_adv_homeassistant.0.2.1.sh &
elif [ "$FW_VERSION" == "0.2.0" ]; then
    $SCRIPT_HOMEASSISTANT/mqtt_adv_homeassistant.0.2.0.sh &
elif [ "$FW_VERSION" == "0.1.9" ]; then
    $SCRIPT_HOMEASSISTANT/mqtt_adv_homeassistant.0.1.9.sh &
else
    $SCRIPT_HOMEASSISTANT/mqtt_adv_homeassistant.0.1.8.sh &
fi
