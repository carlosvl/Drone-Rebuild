---
title: Stock drone hardware
type: entity
sources:
  - docs/photos/dro-q04r-flight-board.jpg
  - docs/photos/motors-and-arm.jpg
  - docs/photos/yd-w9824-camera-board.jpg
  - user (2026-11-09)
updated: 2026-11-09
---

# Stock drone hardware

Toy quadcopter, white plastic frame, prop guards. Identified from photos only.

- **Flight board DRO-Q04R:** MCU + onboard IMU, MOSFET motor drivers (M+/M− pads),
  2.4 GHz receiver with grey antenna lead, 2-pin VCC/GND battery header, ON/OFF switch
  header, F/B LED pads. To be removed and kept unmodified.
- **Motors:** 4× brushed coreless, ~7×20 or 8×20 mm (not measured). Lead colours
  red/blue on one diagonal, white/black on the other (opposite spin).
- **Camera YD-W9824-V1.0 (2017-05-10):** standalone Wi-Fi FPV module, flex to the
  sensor, V+/GND/I-O pads. Out of scope until after first hover.
- **Battery:** not yet checked; assumed 1S LiPo.

Spare boards on hand: an [ESP32 DevKit](esp32-devkit.md) (classic ESP32, confirmed) and an Arduino Zero (unused).
