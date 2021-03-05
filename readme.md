# YI Camera MQTT Script

Plugin for send over MQTT the information of the [YI Hack All Winner](https://github.com/roleoroleo/yi-hack-Allwinner) camera.

It  also have an integrated with Home Assistant to  [MQTT Discovery](https://www.home-assistant.io/docs/mqtt/discovery/).


## DISCLAIMER
NOBODY BUT YOU IS RESPONSIBLE FOR ANY USE OR DAMAGE THIS SOFTWARE MAY CAUSE.
THIS IS INTENDED FOR EDUCATIONAL PURPOSES ONLY. USE AT YOUR OWN RISK.

## HowTo Use

1. Remove power from the cam.
2. Download the files in a FAT32 formatted SD card
3. Edit the file `homeassistant.cfg` according to your needs. Pay attention to the special chars:
    * Use only the following special chars (I don't test any other special caracter ): - 
    * Don't use double quote " 
    * Space chars are allowed for `HOMEASSISTANT_NAME`, `HOMEASSISTANT_MANUFACTURER` and `HOMEASSISTANT_MODEL`

4. When you open the SD card you must have the yi-hack folder with 12 files inside.
```
/ --- yi-hack --- homeassistant.cfg
              |-- mqtt_config_adv.sh
              |-- mqtt_config_set.sh
              |-- mqtt_crond_hourly.sh
              |-- mqtt_crond_teminutes.sh
              |-- mqtt_homeassistant_adv.sh
              |-- mqtt_info_adv.sh
              |-- mqtt_info_global_adv.sh
              |-- mqtt_info_resources_adv.sh
              |-- mqtt_links_adv.sh
              |-- readme.md
              |-- startup.sh
```
5. Insert the SD into the cam and power on it.
6. Reboot the camera

## License

* [MIT licensed](LICENCE).
