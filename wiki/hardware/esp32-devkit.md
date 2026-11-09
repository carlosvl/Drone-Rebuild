---
title: ESP32 dev board
type: entity
sources:
  - docs/photos/esp32-devkit.jpg
  - firmware/esp-drone/main/Kconfig.projbuild
updated: 2026-11-09
---

# ESP32 dev board

Generic 38-pin ESP32 DevKit (clone), identified from photo 2026-11-09:

- Module: shielded "ESP-32 WIFI+BT SoC Inside" (WROOM-32 style), PCB antenna.
  **Classic ESP32**, so the `set-target esp32` / ESPlane V1 build applies ([firmware](../components/firmware.md)).
- USB-C with a CP2102 USB-serial chip (needs no driver on recent macOS); EN and IO0 buttons.
- Onboard 3.3 V regulator looks like an AMS1117 (SOT-223). It needs ~4.3 V+ in, so on a
  1S LiPo (3.0–4.2 V) feed the **3V3 pin** from a low-dropout regulator (ME6211/HT7333)
  and leave 5V/VIN unconnected. Never plug in USB and the battery at the same time
  unless the LDO output is diode-isolated.
- All ESPlane V1 pins used by the firmware are broken out on a 38-pin board:
  4, 33, 32, 25 (motors), 21/22 (I²C), 19 (MPU INT), 35 (battery ADC), 18/5/23 (LEDs).
- Size ~28×52 mm with headers; desolder or don't fit headers to save weight. Not weighed.
