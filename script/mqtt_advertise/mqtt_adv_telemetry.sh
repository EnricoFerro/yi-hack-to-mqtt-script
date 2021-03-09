#!/bin/sh

YI_HACK_PREFIX="/home/yi-hack"
CONF_FILE="etc/mqttv4.conf"
CONF_HOMEASSISTANT_FILE="etc/mqtt_advertise.conf"

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
UPTIME=$(cat /proc/uptime | cut -d ' ' -f1)
LOAD_AVG=$(cat /proc/loadavg | cut -d ' ' -f1-3)
TOTAL_MEMORY=$(free -k | awk 'NR==2{print $2}')
FREE_MEMORY=$(free -k | awk 'NR==2{print $4+$6+$7}')
FREE_SD=$(df /tmp/sd/ | grep mmc | awk '{print $5}' | tr -d '%')
WLAN_STRENGTH=$(cat /proc/net/wireless | awk 'END { print $3 }' | sed 's/\.$//')

# MQTT configuration

LD_LIBRARY_PATH=$YI_HACK_PREFIX/lib:$LD_LIBRARY_PATH

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
MQTT_ADV_TELEMETRY_TOPIC=$(get_homeassistant_config MQTT_ADV_TELEMETRY_TOPIC)
TOPIC=$MQTT_PREFIX/$MQTT_ADV_TELEMETRY_TOPIC

# MQTT Publish
CONTENT="{ "
CONTENT=$CONTENT'"uptime":"'$UPTIME'",'
CONTENT=$CONTENT'"load_avg":"'$LOAD_AVG'",'
if [ ! -z "$FREE_SD" ]; then
    FREE_SD=$((100 - $FREE_SD))%
    CONTENT=$CONTENT'"free_sd":"'$FREE_SD'",'
fi
CONTENT=$CONTENT'"total_memory":"'$TOTAL_MEMORY'",'
CONTENT=$CONTENT'"free_memory":"'$FREE_MEMORY'",'
CONTENT=$CONTENT'"wlan_strength":"'$WLAN_STRENGTH'"'
CONTENT=$CONTENT" }"
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
