---
title: Firmware (ESP-Drone)
type: component
sources:
  - firmware/README.md
  - firmware/sdkconfig.drone
  - firmware/esp-drone/main/Kconfig.projbuild
  - firmware/esp-drone/components/drivers/general/wifi/wifi_esp32.c
updated: 2026-11-09
---

# Firmware (ESP-Drone)

Espressif ESP-Drone (Crazyflie-derived, GPL-3.0) as submodule `firmware/esp-drone`,
pinned at `9d5a4f8` (2026-10-26). ESP-IDF `release/v5.5` or `v6.1`. Espressif gives
it limited support. Build steps: [firmware/README.md](../../firmware/README.md).

- `set-target esp32` selects `TARGET_ESPLANE_V1`. Default pins from Kconfig:
  motors M1–M4 = GPIO 4, 33, 32, 25; I²C0 SDA 21 / SCL 22 (MPU6050);
  MPU INT 19; battery ADC 35; LEDs blue 18 / green 5 / red 23.
- Our overrides (`sdkconfig.drone`): brushed 720 motor profile, SSID prefix `DRONE-REBUILD`.
- Link: SoftAP `192.168.43.42`, UDP 2390, password `12345678`. See [CRTP link](crtp-link.md).
- Not yet built or flashed (ESP-IDF not installed on the Mac as of 2026-11-09).
