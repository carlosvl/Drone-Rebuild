# DroneRemote (iOS)

SwiftUI remote for the ESP-Drone firmware. The Xcode project is generated:

```bash
cd ios/DroneRemote && xcodegen generate && open DroneRemote.xcodeproj
```

Join the drone's `DRONE-REBUILD_…` Wi-Fi, open the app, flip **Armed** at zero throttle.
Left stick: throttle (holds) / yaw. Right stick: roll / pitch (springs back).
Leaving the app disarms.
