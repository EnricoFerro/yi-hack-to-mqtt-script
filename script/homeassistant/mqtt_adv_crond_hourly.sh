#!/bin/sh

YI_HACK_PREFIX="/home/yi-hack"
TMP_SD_YI_HACK_PREFIX="/tmp/sd/yi-hack"

$TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_adv_config.sh
$TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_adv_info_global.sh
$TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_adv_links.sh

$TMP_SD_YI_HACK_PREFIX/script/homeassistant/mqtt_adv_homeassistant.sh
