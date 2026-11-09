# Wiki log

Append-only. Newest entries at the bottom. Heading format:
`## [YYYY-MM-DD] ingest|query|lint|decision | title`

## [2026-11-09] decision | Adopt LLM Wiki pattern
- Bootstrapped from `../_wiki-template/`; schema in `.claude/rules/llm-wiki.md`.
- Wiki is git-tracked with the rest of the project (user request).

## [2026-11-09] decision | Public GitHub repo
- Remote: https://github.com/carlosvl/Drone-Rebuild (public; parentheses not allowed in repo names).

## [2026-11-09] decision | Rebuild architecture
- ESP32 + ESP-Drone firmware + iOS app over Wi-Fi; Arduino Zero unused.

## [2026-11-09] ingest | Hardware photos, firmware, iOS app
- Photos in `docs/photos/`; stock hardware page.
- ESP-Drone submodule + `sdkconfig.drone`; CRTP link and iOS app pages.

## [2026-11-09] ingest | ESP32 dev board identified
- Classic ESP32 38-pin DevKit (USB-C, CP2102); ESPlane V1 build confirmed; power via LDO to 3V3.
