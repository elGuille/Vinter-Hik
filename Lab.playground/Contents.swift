//: Playground - noun: a place where people can play

import Foundation
import UIKit

extension Int {
   static func random＃(min＃: Int = 0, max＃: Int) -> Int { return Int(arc4random_uniform(UInt32((max＃ - min＃) + 1))) + min＃ }
   var years＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int) { return (NSCalendarUnit.Year, self) }
   var months＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int) { return (NSCalendarUnit.Month, self) }
   var days＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int){ return (NSCalendarUnit.Day, self) }
   var hours＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)  { return (NSCalendarUnit.Hour, self) }
   var minutes＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int) { return (NSCalendarUnit.Minute, self) }
   var seconds＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)  { return (NSCalendarUnit.Second, self) }
   var toIndex＃: Int { return self - 1 }
   var formattedWith2Digits$: String { get { return String(format: "%02d", self) } }
   func isMultipleOfⓑ(number＃: Int) -> Bool { return self % number＃ == 0 }
   func isMultipleOfⓑ(number＃: Float) -> Bool { return Float(self) % number＃ == 0 }
   func isMultipleOfⓑ(number＃: CGFloat) -> Bool { return CGFloat(self) % number＃ == 0 }
   func isMultipleOfⓑ(number＃: Double) -> Bool { return Double(self) % number＃ == 0 }
}

var a = 3

a.toIndex＃
