#!/bin/sh

YI_HACK_PREFIX="/home/yi-hack"
CONF_FILE="etc/mqttv4.conf"
CONF_HOMEASSISTANT_FILE="etc/homeassistant.conf"

CONTENT=$(QUERY_STRING="conf=camera" $YI_HACK_PREFIX/www/cgi-bin/get_configs.sh | sed 1d)
PATH=$PATH:$YI_HACK_PREFIX/bin:$YI_HACK_PREFIX/usr/bin
LD_LIBRARY_PATH=$YI_HACK_PREFIX/lib:$LD_LIBRARY_PATH

get_config() {
    key=^$1
    grep -w $key $YI_HACK_PREFIX/$CONF_FILE | cut -d "=" -f2
}

get_homeassistant_config() {
    key=$1
    grep -w $1 $YI_HACK_PREFIX/$CONF_HOMEASSISTANT_FILE | cut -d "=" -f2
}

HOSTNAME=$(hostname)
MQTT_IP=$(get_config MQTT_IP)
MQTT_PORT=$(get_config MQTT_PORT)
MQTT_USER=$(get_config MQTT_USER)
MQTT_PASSWORD=$(get_config MQTT_PASSWORD)

HOST=$MQTT_IP
if [ ! -z $MQTT_PORT ]; then
    HOST=$HOST' -p '$MQTT_PORT
fi
if [ ! -z $MQTT_USER ]; then
    HOST=$HOST' -u '$MQTT_USER' -P '$MQTT_PASSWORD
fi

MQTT_PREFIX=$(get_config MQTT_PREFIX)
MQTT_ADV_CAMERA_SETTING_TOPIC=$(get_homeassistant_config MQTT_ADV_CAMERA_SETTING_TOPIC)
TOPIC=$MQTT_PREFIX/$MQTT_ADV_CAMERA_SETTING_TOPIC

$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
