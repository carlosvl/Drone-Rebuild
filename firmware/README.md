# Firmware

[ESP-Drone](https://github.com/espressif/esp-drone) as a git submodule, built for a plain
ESP32 (`TARGET_ESPLANE_V1` pin map). Our only changes live in `sdkconfig.drone`.

Needs ESP-IDF `release/v5.5` or `release/v6.1` (per the submodule README).

```bash
git submodule update --init
cd firmware/esp-drone
SDKCONFIG_DEFAULTS="sdkconfig.defaults;../sdkconfig.drone" idf.py set-target esp32
idf.py build flash monitor
```

The drone opens a Wi-Fi AP `DRONE-REBUILD_<mac>` (password `12345678`, ESP-Drone default)
and listens for CRTP over UDP at `192.168.43.42:2390`.
