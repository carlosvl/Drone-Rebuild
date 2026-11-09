import XCTest
@testable import DroneRemote

final class CRTPTests: XCTestCase {
    func testZeroSetpointIsHeaderPaddingAndChecksum() {
        let p = CRTP.setpoint(roll: 0, pitch: 0, yawRate: 0, thrust: 0)
        XCTAssertEqual(Array(p), [0x30] + Array(repeating: 0, count: 14) + [0x30])
    }

    func testLayoutMatchesPackedStruct() {
        // roll 1.0 = 0x3F800000, pitch -2.0 = 0xC0000000, yaw 0, thrust 0x1234
        let p = Array(CRTP.setpoint(roll: 1, pitch: -2, yawRate: 0, thrust: 0x1234))
        XCTAssertEqual(p.count, 16)
        XCTAssertEqual(Array(p[1...4]), [0x00, 0x00, 0x80, 0x3F])
        XCTAssertEqual(Array(p[5...8]), [0x00, 0x00, 0x00, 0xC0])
        XCTAssertEqual(Array(p[13...14]), [0x34, 0x12])
        XCTAssertEqual(p[15], p[0..<15].reduce(0, &+))
    }
}
