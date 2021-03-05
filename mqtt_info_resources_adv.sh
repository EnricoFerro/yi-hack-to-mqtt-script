#!/bin/sh
YI_HACK_PREFIX="/home/yi-hack"
CONF_FILE="etc/mqttv4.conf"

PATH=$PATH:$YI_HACK_PREFIX/bin:$YI_HACK_PREFIX/usr/bin

get_config()                                                  
{                                                             
    key=$1                                                    
    grep -w $1 $YI_HACK_PREFIX/$CONF_FILE | cut -d "=" -f2    
}

HOSTNAME=$(hostname)
FW_VERSION=$(cat $YI_HACK_PREFIX/version)
HOME_VERSION=$(cat /home/app/.appver)
MODEL_SUFFIX=$(cat $YI_HACK_PREFIX/model_suffix)
SERIAL_NUMBER=$(dd bs=1 count=20 skip=592 if=/tmp/mmap.info 2>/dev/null | cut -c1-20)
LOCAL_TIME=$(date)
UPTIME=$(cat /proc/uptime | cut -d ' ' -f1)
LOAD_AVG=$(cat /proc/loadavg | cut -d ' ' -f1-3)
TOTAL_MEMORY=$(free -k | awk 'NR==2{print $2}')
FREE_MEMORY=$(free -k | awk 'NR==2{print $4+$6+$7}')
FREE_SD=$(df /tmp/sd/ | grep mmc | awk '{print $5}' | tr -d '%')


LOCAL_IP=$(ifconfig wlan0 | awk '/inet addr/{print substr($2,6)}')
NETMASK=$(ifconfig wlan0 | awk '/inet addr/{print substr($4,6)}')
GATEWAY=$(route -n | awk 'NR==3{print $2}')
MAC_ADDR=$(ifconfig wlan0 | awk '/HWaddr/{print substr($5,1)}')
WLAN_ESSID=$(iwconfig wlan0 | grep ESSID | cut -d\" -f2)
WLAN_STRENGTH=$(cat /proc/net/wireless | awk 'END { print $3 }' | sed 's/\.$//')

# MQTT configuration

LD_LIBRARY_PATH=$YI_HACK_PREFIX/lib:$LD_LIBRARY_PATH 


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
TOPIC=$MQTT_PREFIX'/info/resources'

# MQTT Publish
CONTENT="{ "
CONTENT=$CONTENT'"uptime":"'$UPTIME'",'
CONTENT=$CONTENT'"load_avg":"'$LOAD_AVG'",'
if [ ! -z "$FREE_SD" ]; then
    FREE_SD=$((100-$FREE_SD))%
    CONTENT=$CONTENT'"free_sd":"'$FREE_SD'",'
fi
CONTENT=$CONTENT'"total_memory":"'$TOTAL_MEMORY'",'
CONTENT=$CONTENT'"free_memory":"'$FREE_MEMORY'",'
CONTENT=$CONTENT'"wlan_strength":"'$WLAN_STRENGTH'"'
CONTENT=$CONTENT" }"
$YI_HACK_PREFIX/bin/mosquitto_pub -r -h $HOST -t $TOPIC -m "$CONTENT"
