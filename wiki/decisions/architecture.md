---
title: Rebuild architecture
type: decision
sources:
  - user (2026-11-09)
  - https://docs.espressif.com/projects/espressif-esp-drone/en/latest/hardware.html
updated: 2026-11-09
---

# Rebuild architecture

Decided 2026-11-09 (plan approved by the user):

- Replace the DRO-Q04R with an **ESP32 + MPU6050 + 4 low-side MOSFETs** on perfboard,
  copying the ESPlane-FC-V1 pin map so stock [ESP-Drone](../components/firmware.md) runs.
- Control from an **iPhone over Wi-Fi** ([app](../components/ios-app.md)); no original remote.
- Arduino Zero not used. Stock board kept, not modified.
- Parts to buy: GY-521 MPU6050, 4× AO3400/SI2302, 4× SS14, 4× 10 kΩ, ME6211/HT7333 LDO
  (dev-board AMS1117 browns out on 1S), perfboard.
- Open: the FPV camera has its own Wi-Fi; the phone can only join one network.
