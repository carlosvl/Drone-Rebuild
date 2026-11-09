# Drone(Rebuild) wiki — index

This knowledge base is maintained by Claude; the rules are in
`.claude/rules/llm-wiki.md`. Start every task here.

## Overview

- [Overview](overview.md) — what this project is and where it stands

## Hardware

- [Stock drone hardware](hardware/stock-drone.md) — DRO-Q04R board, brushed motors, W9824 camera
- [ESP32 dev board](hardware/esp32-devkit.md) — classic ESP32 DevKit, power from 1S via LDO to 3V3

## Components

- [Firmware (ESP-Drone)](components/firmware.md) — submodule, ESP32 pin map, overrides
- [CRTP over Wi-Fi link](components/crtp-link.md) — UDP packet format, thrust lock, signs
- [iOS app (DroneRemote)](components/ios-app.md) — SwiftUI remote, limits, failsafe

## Decisions

- [Rebuild architecture](decisions/architecture.md) — ESP32 + MPU6050 + MOSFETs, iPhone over Wi-Fi
