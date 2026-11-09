import Foundation
import Network
import Observation

/// Streams the stick state to the drone at 50 Hz. Disarmed always sends zero thrust,
/// which is also what unlocks the firmware's thrust lock.
@MainActor @Observable
final class DroneLink {
    static let maxAngle: Float = 15      // deg, matches ESP-Drone's own app
    static let maxYawRate: Float = 120   // deg/s

    var armed = false
    var connected = false
    /// Sticks in -1...1. throttle is 0...1.
    var throttle: Float = 0
    var yaw: Float = 0
    var roll: Float = 0
    var pitch: Float = 0

    private let connection = NWConnection(
        host: NWEndpoint.Host(CRTP.host), port: NWEndpoint.Port(rawValue: CRTP.port)!, using: .udp)
    private var timer: Timer?

    func start() {
        connection.stateUpdateHandler = { [weak self] state in
            Task { @MainActor in self?.connected = (state == .ready) }
        }
        connection.start(queue: .main)
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] _ in
            MainActor.assumeIsolated { self?.send() }
        }
    }

    func stop() {
        armed = false
        send()
        timer?.invalidate()
        timer = nil
    }

    private func send() {
        let thrust = armed ? UInt16(max(0, min(1, throttle)) * Float(CRTP.maxThrust)) : 0
        // Stick forward = negative pitch, same as ESP-Drone's legacy and ESP-NOW remotes.
        let packet = CRTP.setpoint(
            roll: roll * Self.maxAngle, pitch: -pitch * Self.maxAngle,
            yawRate: yaw * Self.maxYawRate, thrust: thrust)
        connection.send(content: packet, completion: .idempotent)
    }
}
