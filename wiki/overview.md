---
title: Overview
type: overview
sources:
  - user (2026-11-09)
updated: 2026-11-09
---

# Overview

Rebuild of a toy quadcopter ([stock hardware](hardware/stock-drone.md)) with an ESP32
flight controller running ESP-Drone, flown from an iPhone app.
See [architecture](decisions/architecture.md).

## Status (2026-11-09)

- Done: firmware submodule + config, iOS app with tested packet encoder.
- ESP32 confirmed as classic ESP32 ([dev board](hardware/esp32-devkit.md)).
- Next (hands-on): confirm battery and motor size; buy parts; bench-wire
  with props off; install ESP-IDF and flash.
- Later: battery telemetry in the app, FPV camera.
