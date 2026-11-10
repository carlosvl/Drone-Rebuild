# How it all fits together

Diagrams render on GitHub (Mermaid). Pin numbers are ESP-Drone's `TARGET_ESPLANE_V1`
defaults (`firmware/esp-drone/main/Kconfig.projbuild`). Nothing here is bench-verified yet.

## 1. System overview

```mermaid
flowchart LR
    subgraph Phone["iPhone"]
        App["DroneRemote app<br/>sticks + Arm"]
    end

    subgraph Drone["Drone frame"]
        ESP["ESP32 DevKit<br/>ESP-Drone firmware"]
        IMU["MPU6050<br/>gyro + accel"]
        DRV["4× MOSFET<br/>motor drivers"]
        MOT["4× brushed<br/>coreless motors"]
        BAT["1S LiPo<br/>3.0–4.2 V"]
        LDO["3.3 V LDO<br/>ME6211 / HT7333"]
        LED["Status LEDs"]
    end

    CAM["YD-W9824 camera<br/>(later, own Wi-Fi)"]

    App -- "Wi-Fi: SoftAP DRONE-REBUILD_…<br/>UDP 192.168.43.42:2390<br/>CRTP setpoints @ 50 Hz" --> ESP
    IMU -- "I²C + INT" --> ESP
    ESP -- "4× PWM" --> DRV
    DRV --> MOT
    BAT --> DRV
    BAT --> LDO
    LDO -- "3V3" --> ESP
    LDO -- "3V3" --> IMU
    BAT -. "÷2 divider → ADC" .-> ESP
    ESP --> LED
    BAT -.-> CAM
```

## 2. Wiring (ESP32 pin map)

```mermaid
flowchart LR
    ESP["ESP32 DevKit<br/>(38-pin)"]
    IMU["GY-521 MPU6050"]
    Q1["MOSFET 1 → M1<br/>front-right"]
    Q2["MOSFET 2 → M2<br/>back-right"]
    Q3["MOSFET 3 → M3<br/>back-left"]
    Q4["MOSFET 4 → M4<br/>front-left"]
    DIV["100k / 100k divider<br/>from battery +"]
    LEDS["LEDs via resistors"]
    LDO["3.3 V LDO"]

    ESP -- "GPIO21 → SDA<br/>GPIO22 → SCL<br/>GPIO19 → INT" --- IMU
    LDO -- "3V3 pin" --> ESP
    LDO -- "VCC" --> IMU
    ESP -- "GPIO4" --> Q1
    ESP -- "GPIO33" --> Q2
    ESP -- "GPIO32" --> Q3
    ESP -- "GPIO25" --> Q4
    DIV -- "GPIO35 (ADC)" --> ESP
    ESP -- "GPIO18 blue<br/>GPIO5 green<br/>GPIO23 red" --> LEDS
```

All grounds are common: battery −, LDO, ESP32 GND, MPU6050 GND, MOSFET sources.

Leave the DevKit's **5V/VIN pin unconnected**; power enters only at 3V3 from the LDO
(see [ESP32 dev board](../wiki/hardware/esp32-devkit.md)).

## 3. Power

```mermaid
flowchart TB
    BAT["1S LiPo +"] --> SW["Stock ON/OFF switch"]
    SW --> VBAT(("VBAT rail"))
    VBAT --> MP["Motor + leads ×4"]
    VBAT --> LDO["LDO 3.3 V<br/>+ 10 µF in/out"]
    VBAT --> DIV["100k/100k divider → GPIO35"]
    VBAT -.-> CAM["Camera V+ (later)"]
    LDO --> ESP["ESP32 3V3 pin"]
    LDO --> IMU["MPU6050 VCC"]
    MP --> MOS["MOSFET drain ×4<br/>(low side)"]
    MOS --> GND(("GND"))
    ESP --- GND
    IMU --- GND
    BATN["1S LiPo −"] --- GND
```

## 4. One motor channel (×4)

```mermaid
flowchart LR
    VBAT(("VBAT")) --> MP["Motor +"]
    MP --> M(["Motor"])
    M --> MN["Motor −"]
    MN --> D["MOSFET drain<br/>AO3400 / SI2302"]
    D --> S["source → GND"]
    PWM["ESP32 PWM pin"] --> GATE["gate"]
    GATE --- D
    GATE --> RPD["10 kΩ pull-down → GND"]
    SK["SS14 Schottky<br/>anode at Motor −, cathode at VBAT"] -.- M
```

The pull-down keeps motors off while the ESP32 boots; the diode absorbs the motor's
voltage spike when the MOSFET turns off.

## 5. Motor layout (top view, nose up)

```
        FRONT
   M4 ●       ● M1
      \       /
        [ESP]
      /       \
   M3 ●       ● M2
        BACK
```

ESP-Drone uses X mode (`power_distribution_stock.c`). Diagonal pairs M1/M3 and M2/M4
spin the same way, and the two pairs spin opposite to each other. The stock lead colours
already split the motors this way: red/blue on one diagonal, white/black on the other.
Check each motor's direction on the bench (props off) and swap its two leads if it's wrong.

## 6. One control cycle

```mermaid
sequenceDiagram
    participant U as You (thumbs)
    participant A as DroneRemote app
    participant W as ESP32 Wi-Fi task
    participant S as Stabilizer (PID)
    participant I as MPU6050
    participant M as Motors

    U->>A: move sticks / flip Arm
    loop every 20 ms
        A->>W: UDP: 0x30 + roll, pitch, yaw rate, thrust + checksum
        W->>W: check checksum, unlock thrust after a 0-thrust packet
        W->>S: setpoint
    end
    loop 1 kHz inside the ESP32
        I->>S: gyro + accel
        S->>S: attitude estimate, PID
        S->>M: X-mixer → 4 PWM duty cycles
    end
    Note over A,W: App leaves foreground → Armed off → thrust 0
```
