# YI Camera MQTT Script

Plugin for send over MQTT the information of the [YI Hack All Winner](https://github.com/roleoroleo/yi-hack-Allwinner) camera.

It  also have an integrated with Home Assistant to  [MQTT Discovery](https://www.home-assistant.io/docs/mqtt/discovery/).


## DISCLAIMER
NOBODY BUT YOU IS RESPONSIBLE FOR ANY USE OR DAMAGE THIS SOFTWARE MAY CAUSE.
THIS IS INTENDED FOR EDUCATIONAL PURPOSES ONLY. USE AT YOUR OWN RISK.

## HowTo Use

1. Remove power from the cam.
2. Download the files in a FAT32 formatted SD card
3. Edit the file `etc/homeassistant.conf` according to your needs. Pay attention to the special chars:
    * Use only the following special chars (I don't test any other special caracter ): - 
    * Don't use double quote " 
    * Space chars are allowed for `HOMEASSISTANT_NAME`, `HOMEASSISTANT_MANUFACTURER` and `HOMEASSISTANT_MODEL`

4. When you open the SD card you must have the yi-hack folder with 17 files inside.
```
/ --- yi-hack -
              |-- etc -
                      |- homeassistant.conf
              |-- script -
                         |- homeassistant - 
                                          |-- mqtt_adv_crond_teminutes.sh
                                          |-- mqtt_adv_homeassistant.0.1.8.sh
                                          |-- mqtt_adv_homeassistant.0.1.9.sh
                                          |-- mqtt_adv_homeassistant.0.2.0.sh
                                          |-- mqtt_adv_homeassistant.0.2.1.sh
                                          |-- mqtt_adv_homeassistant.0.2.3.sh
                                          |-- mqtt_adv_info_global.sh
                                          |-- mqtt_adv_telemetry.sh
                                          |-- mqtt_adv_links.sh
                                          |-- mqtt_adv_config.sh
                                          |-- mqtt_set_config.0.2.3.sh
                                          |-- mqtt_set_config.sh
              |-- www - 
                      |- pages -
                               |- homeassistant.html
                      |- js - 
                            |- modules -
                                       |- homeassistant.js 
              |-- readme.md
              |-- startup.sh
```
5. Insert the SD into the cam and power on it.
6. Reboot the camera

## Web interface

It is possible to modify the configuration by the page:
```
http://<YOU_CAM_IP>/index.html?page=homeassistant
```

## Remove 

1. Delete all content in `/tmp/sd/yi-hack`
2. Delete `/home/yi-hack/etc/homeassistant.conf`
3. Delete `/home/yi-hack/www/pages/homeassistant.html`
4. Delete `/home/yi-hack/www/js/homeassistant.js`


## License

* [MIT licensed](LICENCE).
