
import Foundation

struct BitMaskCategory {
  static let player  : UInt32 = 0x1 << 0 //00000000000...01  1
  static let enemy   : UInt32 = 0x1 << 1 //00000000000...10  2
  static let powerUp : UInt32 = 0x1 << 2 //0000000000...100  4
  static let shot    : UInt32 = 0x1 << 3 //000000000...1000  8
}

