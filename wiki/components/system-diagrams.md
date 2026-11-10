---
title: System diagrams
type: synthesis
sources:
  - docs/diagrams.md
  - firmware/esp-drone/main/Kconfig.projbuild
  - firmware/esp-drone/components/core/crazyflie/modules/src/power_distribution_stock.c
  - firmware/esp-drone/components/core/crazyflie/hal/src/pm_esplane.c
  - firmware/esp-drone/components/core/crazyflie/modules/interface/stabilizer_types.h
updated: 2026-11-09
---

# System diagrams

Mermaid diagrams in [docs/diagrams.md](../../docs/diagrams.md) (render on GitHub):
system overview, ESP32 pin map, power, one motor channel, motor layout, control cycle.

Facts they rest on (from firmware source, 2026-11-09):
- X-mode mixer: M1 front-right, M2 back-right, M3 back-left, M4 front-left;
  M1/M3 and M2/M4 are the same-direction diagonal pairs.
- Battery is read on GPIO35 with multiplier 2, so the divider is two equal resistors (÷2).
- Main stabilizer loop 1 kHz, attitude PID 500 Hz.
- All 5 Mermaid blocks parse and render with Mermaid 11.4.1 (checked 2026-11-09).

Not bench-verified: motor spin direction per lead colour, pitch sign.
