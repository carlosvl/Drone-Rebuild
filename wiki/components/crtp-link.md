---
title: CRTP over Wi-Fi link
type: concept
sources:
  - firmware/esp-drone/components/drivers/general/wifi/wifi_esp32.c
  - firmware/esp-drone/components/core/crazyflie/hal/src/wifilink.c
  - firmware/esp-drone/components/core/crazyflie/modules/src/crtp_commander_rpyt.c
  - ios/DroneRemote/Sources/CRTP.swift
updated: 2026-11-09
---

# CRTP over Wi-Fi link

UDP datagram = CRTP header byte + payload + 1-byte checksum (sum of all previous bytes, mod 256).

Setpoint (header `0x30` = port 3, channel 0), 14-byte packed little-endian payload:
`float roll (deg), float pitch (deg), float yaw (deg/s), uint16 thrust`.

- **Thrust lock:** firmware ignores thrust until it gets a packet with thrust 0.
  The app always sends 0 while disarmed.
- **Sign:** stick forward = negative pitch (both ESP-Drone's legacy app and ESP-NOW
  remote do this). Not yet bench-verified on this frame.
- No telemetry parsed yet (battery needs CRTP log TOC setup).
