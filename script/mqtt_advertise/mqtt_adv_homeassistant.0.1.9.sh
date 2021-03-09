#!/bin/sh

YI_HACK_PREFIX="/home/yi-hack"
CONF_FILE="etc/mqttv4.conf"

CONF_MQTT_ADVERTISE_FILE="etc/mqtt_advertise.conf"
PATH=$PATH:$YI_HACK_PREFIX/bin:$YI_HACK_PREFIX/usr/bin
LD_LIBRARY_PATH=$YI_HACK_PREFIX/lib:$LD_LIBRARY_PATH

get_config() {
    key=^$1
    grep -w $key $YI_HACK_PREFIX/$CONF_FILE | cut -d "=" -f2
}

get_mqtt_advertise_config() {
    key=$1
    grep -w $1 $YI_HACK_PREFIX/$CONF_MQTT_ADVERTISE_FILE | cut -d "=" -f2
}

HOSTNAME=$(hostname)
MQTT_IP=$(get_config MQTT_IP)
MQTT_PORT=$(get_config MQTT_PORT)
MQTT_USER=$(get_config MQTT_USER)
MQTT_PASSWORD=$(get_config MQTT_PASSWORD)
MQTT_QOS=$(get_config MQTT_QOS)

TOPIC_MOTION=$(get_config TOPIC_MOTION)
MOTION_START_MSG=$(get_config MOTION_START_MSG)
MOTION_STOP_MSG=$(get_config MOTION_STOP_MSG)

TOPIC_AI_HUMAN_DETECTION=$(get_config TOPIC_AI_HUMAN_DETECTION)
AI_HUMAN_DETECTION_START_MSG=$(get_config AI_HUMAN_DETECTION_START_MSG)
AI_HUMAN_DETECTION_STOP_MSG=$(get_config AI_HUMAN_DETECTION_STOP_MSG)

TOPIC_BABY_CRYING=$(get_config TOPIC_BABY_CRYING)
BABY_CRYING_MSG=$(get_config BABY_CRYING_MSG)

HOST=$MQTT_IP
if [ ! -z $MQTT_PORT ]; then
    HOST=$HOST' -p '$MQTT_PORT
fi
if [ ! -z $MQTT_USER ]; then
    HOST=$HOST' -u '$MQTT_USER' -P '$MQTT_PASSWORD
fi

MQTT_PREFIX=$(get_config MQTT_PREFIX)

HOMEASSISTANT_MQTT_PREFIX=$(get_mqtt_advertise_config HOMEASSISTANT_MQTT_PREFIX)
MQTT_ADV_INFO_GLOBAL_TOPIC=$(get_mqtt_advertise_config MQTT_ADV_INFO_GLOBAL_TOPIC)
MQTT_ADV_CAMERA_SETTING_TOPIC=$(get_mqtt_advertise_config MQTT_ADV_CAMERA_SETTING_TOPIC)
MQTT_ADV_TELEMETRY_TOPIC=$(get_mqtt_advertise_config MQTT_ADV_TELEMETRY_TOPIC)
NAME=$(get_mqtt_advertise_config HOMEASSISTANT_NAME)
IDENTIFIERS=$(get_mqtt_advertise_config HOMEASSISTANT_IDENTIFIERS)
MANUFACTURER=$(get_mqtt_advertise_config HOMEASSISTANT_MANUFACTURER)
MODEL=$(get_mqtt_advertise_config HOMEASSISTANT_MODEL)
SW_VERSION=$(cat $YI_HACK_PREFIX/version)

#Hostname
UNIQUE_NAME=$NAME" Hostname"
UNIQUE_ID=$IDENTIFIERS"-hostname"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/hostname/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:network","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.hostname }}"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#IP
UNIQUE_NAME=$NAME" Local IP"
UNIQUE_ID=$IDENTIFIERS"-local_ip"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/local_ip/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:ip","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.local_ip }}"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#Netmask
UNIQUE_NAME=$NAME" Netmask"
UNIQUE_ID=$IDENTIFIERS"-netmask"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/netmask/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:ip","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.netmask }}"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#Gateway
UNIQUE_NAME=$NAME" Gateway"
UNIQUE_ID=$IDENTIFIERS"-gateway"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/gateway/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:ip","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.gateway }}"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#WLan ESSID
UNIQUE_NAME=$NAME" WiFi ESSID"
UNIQUE_ID=$IDENTIFIERS"-wlan_essid"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/wlan_essid/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:wifi","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.wlan_essid }}"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#Mac Address
UNIQUE_NAME=$NAME" Mac Address"
UNIQUE_ID=$IDENTIFIERS"-mac_addr"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/mac_addr/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:network","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.mac_addr }}"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#Home Version
UNIQUE_NAME=$NAME" Home Version"
UNIQUE_ID=$IDENTIFIERS"-home_version"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/home_version/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:memory","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.home_version }}"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#Firmware Version
UNIQUE_NAME=$NAME" Firmware Version"
UNIQUE_ID=$IDENTIFIERS"-fw_version"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/fw_version/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:network","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.fw_version }}"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#Model Suffix
UNIQUE_NAME=$NAME" Model Suffix"
UNIQUE_ID=$IDENTIFIERS"-model_suffix"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/model_suffix/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:network","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.model_suffix }}"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#Serial Number
UNIQUE_NAME=$NAME" Serial Number"
UNIQUE_ID=$IDENTIFIERS"-serial_number"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/serial_number/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:webcam","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_INFO_GLOBAL_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.serial_number }}"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"

#Total Memory
UNIQUE_NAME=$NAME" Total Memory"
UNIQUE_ID=$IDENTIFIERS"-total_memory"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/total_memory/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:memory","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_TELEMETRY_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_TELEMETRY_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.total_memory }}","unit_of_measurement":"KB"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#Free Memory
UNIQUE_NAME=$NAME" Free Memory"
UNIQUE_ID=$IDENTIFIERS"-free_memory"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/free_memory/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:memory","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_TELEMETRY_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_TELEMETRY_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.free_memory }}","unit_of_measurement":"KB"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#FreeSD
UNIQUE_NAME=$NAME" Free SD"
UNIQUE_ID=$IDENTIFIERS"-free_sd"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/free_sd/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:micro-sd","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_TELEMETRY_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_TELEMETRY_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.free_sd|regex_replace(find=\"%\", replace=\"\", ignorecase=False) }}","unit_of_measurement":"%"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#Load AVG
UNIQUE_NAME=$NAME" Load AVG"
UNIQUE_ID=$IDENTIFIERS"-load_avg"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/load_avg/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:network","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_TELEMETRY_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_TELEMETRY_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.load_avg }}"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#Uptime
UNIQUE_NAME=$NAME" Uptime"
UNIQUE_ID=$IDENTIFIERS"-uptime"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/uptime/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"device_class":"timestamp","icon":"mdi:timer-outline","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_TELEMETRY_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_TELEMETRY_TOPIC'","name":"'$UNIQUE_NAME'","'unique_id'":"'$UNIQUE_ID'","value_template":"{{ (as_timestamp(now())-(value_json.uptime|int))|timestamp_local }}"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
#WLanStrenght
UNIQUE_NAME=$NAME" Wlan Strengh"
UNIQUE_ID=$IDENTIFIERS"-wlan_strength"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/sensor/$IDENTIFIERS/wlan_strength/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"device_class":"signal_strength","icon":"mdi:wifi","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_TELEMETRY_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_TELEMETRY_TOPIC'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ ((value_json.wlan_strength|int) * 100 / 70 )|int }}","unit_of_measurement":"%"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"

# Motion Detection
UNIQUE_NAME=$NAME" Movement"
UNIQUE_ID=$IDENTIFIERS"-motion_detection"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/binary_sensor/$IDENTIFIERS/motion_detection/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"}, "qos": "'$MQTT_QOS'", "device_class":"motion","state_topic":"'$MQTT_PREFIX'/'$TOPIC_MOTION'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","payload_on":"'$MOTION_START_MSG'","payload_off":"'$MOTION_STOP_MSG'"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
# Human Detection
UNIQUE_NAME=$NAME" Human Detection"
UNIQUE_ID=$IDENTIFIERS"-ai_human_detection"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/binary_sensor/$IDENTIFIERS/ai_human_detection/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"}, "qos": "'$MQTT_QOS'", "device_class":"motion","state_topic":"'$MQTT_PREFIX'/'$TOPIC_AI_HUMAN_DETECTION'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","payload_on":"'$AI_HUMAN_DETECTION_START_MSG'","payload_off":"'$AI_HUMAN_DETECTION_STOP_MSG'"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
# Sound Detection
UNIQUE_NAME=$NAME" Sound Detection"
UNIQUE_ID=$IDENTIFIERS"-baby_crying"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/binary_sensor/$IDENTIFIERS/baby_crying/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"}, "qos": "'$MQTT_QOS'", "device_class":"sound","state_topic":"'$MQTT_PREFIX'/'$TOPIC_BABY_CRYING'","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","payload_on":"'$BABY_CRYING_MSG'","off_delay":60}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"



# Switch On
UNIQUE_NAME=$NAME" Switch Status"
UNIQUE_ID=$IDENTIFIERS"-SWITCH_ON"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/switch/$IDENTIFIERS/SWITCH_ON/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:video","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'","command_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'/SWITCH_ON/set","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.SWITCH_ON }}","payload_on":"yes","payload_off":"no"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
# Baby Crying
UNIQUE_NAME=$NAME" Baby Crying"
UNIQUE_ID=$IDENTIFIERS"-BABY_CRYING_DETECT"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/switch/$IDENTIFIERS/BABY_CRYING_DETECT/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:emoticon-cry-outline","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'","command_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'/BABY_CRYING_DETECT/set","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.BABY_CRYING_DETECT }}","payload_on":"yes","payload_off":"no"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
# Led
UNIQUE_NAME=$NAME" Status Led"
UNIQUE_ID=$IDENTIFIERS"-LED"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/switch/$IDENTIFIERS/LED/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:led-on","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'","command_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'/LED/set","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.LED }}","payload_on":"yes","payload_off":"no"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
# IR
UNIQUE_NAME=$NAME" IR Led"
UNIQUE_ID=$IDENTIFIERS"-IR"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/switch/$IDENTIFIERS/IR/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:remote","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'","command_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'/IR/set","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.IR }}","payload_on":"yes","payload_off":"no"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
# Rotate
UNIQUE_NAME=$NAME"  Rotate"
UNIQUE_ID=$IDENTIFIERS"-ROTATE"
TOPIC=$HOMEASSISTANT_MQTT_PREFIX/switch/$IDENTIFIERS/ROTATE/config
CONTENT='{"device":{"identifiers":["'$IDENTIFIERS'"],"manufacturer":"'$MANUFACTURER'","model":"'$MODEL'","name":"'$NAME'","sw_version":"'$SW_VERSION'"},"icon":"mdi:monitor","json_attributes_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'","state_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'","command_topic":"'$MQTT_PREFIX'/'$MQTT_ADV_CAMERA_SETTING_TOPIC'/ROTATE/set","name":"'$UNIQUE_NAME'","unique_id":"'$UNIQUE_ID'","value_template":"{{ value_json.ROTATE }}","payload_on":"yes","payload_off":"no"}'
$YI_HACK_PREFIX/bin/mosquitto_pub -i $HOSTNAME -r -h $HOST -t $TOPIC -m "$CONTENT"
