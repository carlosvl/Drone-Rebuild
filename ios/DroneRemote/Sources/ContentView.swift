import SwiftUI

struct ContentView: View {
    @State private var link = DroneLink()
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        HStack(spacing: 40) {
            // Left: throttle holds its height, yaw springs back.
            Stick(x: $link.yaw, y: $link.throttle, yRange: 0...1, springY: false)
            VStack(spacing: 16) {
                Label(link.connected ? "Linked" : "No link",
                      systemImage: link.connected ? "wifi" : "wifi.slash")
                Toggle("Armed", isOn: $link.armed)
                    .toggleStyle(.button)
                    .tint(link.armed ? .red : .gray)
                    .disabled(link.throttle > 0.05 && !link.armed)  // arm only at zero throttle
                Text("Join the DRONE-REBUILD Wi-Fi first")
                    .font(.caption).foregroundStyle(.secondary)
            }
            Stick(x: $link.roll, y: $link.pitch, yRange: -1...1, springY: true)
        }
        .padding()
        .onAppear { link.start() }
        .onChange(of: scenePhase) { _, phase in
            if phase != .active { link.armed = false }  // failsafe: leaving the app cuts thrust
        }
    }
}

/// A square joystick pad. Values: x in -1...1, y in yRange (up is positive).
struct Stick: View {
    @Binding var x: Float
    @Binding var y: Float
    let yRange: ClosedRange<Float>
    let springY: Bool
    private let size: CGFloat = 200

    var body: some View {
        let knob = CGPoint(x: CGFloat(x + 1) / 2 * size,
                           y: (1 - CGFloat((y - yRange.lowerBound) / (yRange.upperBound - yRange.lowerBound))) * size)
        ZStack {
            RoundedRectangle(cornerRadius: 24).fill(.quaternary)
            Circle().fill(.tint).frame(width: 56, height: 56).position(knob)
        }
        .frame(width: size, height: size)
        .gesture(DragGesture(minimumDistance: 0)
            .onChanged { g in
                let nx = Float(max(0, min(size, g.location.x)) / size)
                let ny = Float(1 - max(0, min(size, g.location.y)) / size)
                x = nx * 2 - 1
                y = yRange.lowerBound + ny * (yRange.upperBound - yRange.lowerBound)
            }
            .onEnded { _ in
                x = 0
                if springY { y = 0 }
            })
        .accessibilityElement()
        .accessibilityLabel(springY ? "Roll and pitch stick" : "Throttle and yaw stick")
        .accessibilityValue("x \(Int(x * 100)), y \(Int(y * 100))")
    }
}
