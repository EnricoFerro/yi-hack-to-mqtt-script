#!/bin/sh

YI_HACK_PREFIX="/home/yi-hack"
CONF_FILE="etc/mqttv4.conf"

CONTENT=$($YI_HACK_PREFIX/www/cgi-bin/links.sh | sed 1d | sed ':a;N;$!ba;s/\n//g')

LD_LIBRARY_PATH=$YI_HACK_PREFIX/lib:$LD_LIBRARY_PATH 
PATH=$PATH:$YI_HACK_PREFIX/bin:$YI_HACK_PREFIX/usr/bin
                                       
get_config()                                                  
{                                                             
    key=$1                                                    
    grep -w $1 $YI_HACK_PREFIX/$CONF_FILE | cut -d "=" -f2    
}                                                             

HOSTNAME=$(hostname)
MQTT_IP=$(get_config MQTT_IP)
MQTT_PORT=$(get_config MQTT_PORT)
MQTT_USER=$(get_config MQTT_USER)
MQTT_PASSWORD=$(get_config MQTT_PASSWORD)

HOST=$MQTT_IP
if [ ! -z $MQTT_PORT ]; 
    then HOST=$HOST' -p '$MQTT_PORT;
fi;
if [ ! -z $MQTT_USER ]; 
    then HOST=$HOST' -u '$MQTT_USER' -P '$MQTT_PASSWORD;
fi;

MQTT_PREFIX=$(cat $YI_HACK_PREFIX/etc/mqttv4.conf | grep MQTT_PREFIX= | cut -c 13-)
TOPIC=$MQTT_PREFIX'/links'


$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"