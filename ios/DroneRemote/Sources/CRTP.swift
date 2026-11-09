import Foundation

/// ESP-Drone's Wi-Fi framing of Crazyflie CRTP packets
/// (firmware/esp-drone/components/drivers/general/wifi/wifi_esp32.c).
enum CRTP {
    static let host = "192.168.43.42"
    static let port: UInt16 = 2390
    static let maxThrust: UInt16 = 60000

    /// Commander setpoint (port 3, channel 0): packed little-endian
    /// `float roll, float pitch, float yawRate, uint16 thrust`, then a 1-byte sum checksum.
    /// Firmware keeps thrust locked until it receives a packet with thrust == 0.
    static func setpoint(roll: Float, pitch: Float, yawRate: Float, thrust: UInt16) -> Data {
        var bytes: [UInt8] = [0x30]
        for f in [roll, pitch, yawRate] {
            withUnsafeBytes(of: f.bitPattern.littleEndian) { bytes += $0 }
        }
        withUnsafeBytes(of: thrust.littleEndian) { bytes += $0 }
        bytes.append(bytes.reduce(0, &+))
        return Data(bytes)
    }
}
