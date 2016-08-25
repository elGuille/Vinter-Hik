
//  HikarianLibrary.swift
//
//  Created by Hikarus on 14/06/01.
//  Copyright (c) 2014 Hikarian. All rights reserved.
//

/* VARIABLE TYPE SUFFIX CRITERION

   Boolean              ⓑ
   String               $
   number               ＃
   Int                  ＃i
   Float                ＃f
   Double               ＃d
   CGFloat              ⓖ
   CGPoint              ⓖ²    2 dimensional CGFloats
   CGRect               ⓖ⁴    4 dimensional CGFloats
   Binary/Data          ß     For NSData, and images or videos in CoreData
   Core Image           ⓘ
   NSDate               ㊐
   Object               ⓞ
   Tuple                🅣
   Array                🅐
   Set                  ...     ? not sure about this one...
   Dictionary           🅓
   Enumeration          🅔
   Structure            🅢
   Library Class        ＋
   Complex Structure    ﹙﹚
   Undetermined         ﹖     for Uudetermined types: Optional or AnyObject
   Implicitly unwrapped ﹗
   Protocol             Ⓟ
   Function             ƒ
   Pointer              ⓟ⃗
   PhotoAsset           ⓐ
   Collection           🅒
   WRAPPER/DYNAMIC      🅆  (Alt + Shift + W)
   DB Root              🅁
   DB Branch            🄱
   IBOutlets            ﹫

*/

import Foundation
import UIKit
import Photos
import CoreData
import MapKit


// MARK: EXPERIMENTAL —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————


// CoreImage objects have suffix ⓘ?
//let ciContext = CIContext(options: nil) // these filter clasess must be initialized at boot 'cos they are processor consumming and would delay the UI flow
//let gaussianBlurFilter = CIFilter(name: "CIGaussianBlur", withInputParameters: nil)!
//let colorControlFilter = CIFilter(name: "CIColorControls", withInputParameters: nil)! // inputParameters: [String : AnyObject]? 例: ["inputImage": inImage, "inputSaturation": 0.5, inputBrightness: 1.2, inputContrast: 1.3]
//func gaussianBlur() {
//   let rasterUIImage = exitingSceneUIElements[0].rasterizedToImage
//   let blurRadius: CGFloat = 12
//   gaussianBlurFilter.setValue(CIImage(image: rasterUIImage), forKey: kCIInputImageKey); gaussianBlurFilter.setValue(blurRadius, forKey: kCIInputRadiusKey) // must use CIImage(image: rasterUIImage) because rasterUIImage.CIImage produces nil ( => not working)
//   let filteredCGImage: CGImage = ciContext.createCGImage(gaussianBlurFilter.outputImage!, fromRect: gaussianBlurFilter.outputImage!.extent)
//
//   // seems that the gaussian blur margin is (blurRadius, blurRadius, width - blurRadius*2, height - blurRadius * 2)
//
//   let croppedFilteredCGImage = CGImageCreateWithImageInRect(filteredCGImage, CGRectMake(blurRadius, blurRadius, CGFloat(CGImageGetWidth(filteredCGImage))  - blurRadius*10, CGFloat(CGImageGetHeight(filteredCGImage))  - blurRadius*2))!
//
//   let filteredUIImageView = UIImageView(image: UIImage(CGImage: croppedFilteredCGImage))
//   filteredUIImageView.setFrame(width: sceneW, height: sceneH)
//   view.addSubview(filteredUIImageView)
//   view.bringSubviewToFront(filteredUIImageView)
//}

/*

FILTERS:  CIBumpDistortion, CIGaussianBlur, CIPixellate, CISepiaTone, CITwirlDistortion, CIUnsharpMask, CIVignette

FILTER PARAMETERS: kCIOutputImageKey, kCIInputBackgroundImageKey, kCIInputImageKey, kCIInputTimeKey, kCIInputTransformKey, kCIInputScaleKey, kCIInputAspectRatioKey, kCIInputCenterKey, kCIInputRadiusKey, kCIInputAngleKey, kCIInputRefractionKey, kCIInputWidthKey, kCIInputSharpnessKey, kCIInputIntensityKey, kCIInputEVKey, kCIInputSaturationKey, kCIInputColorKey, kCIInputBrightnessKey, kCIInputContrastKey, kCIInputBiasKey, kCIInputWeightsKey, kCIInputGradientImageKey, kCIInputMaskImageKey, kCIInputShadingImageKey, kCIInputTargetImageKey, kCIInputExtentKey, kCIInputVersionKey

*/

// MARK: PROTOCOLS —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

protocol HasContextID$Ⓟ { var contextID$: String? { get set } }
protocol HasContextualInfo$Ⓟ { var contextualInfo$: String? { get set } }
protocol HasCoordinates$Ⓟ { var x$: String? { get set } ; var y$: String? { get set } }

// MARK: GENERAL VARIABLES —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
var keyboardHeightⓖ = CGFloat() // this value is assigned by the return of the function slideForKeyboardAndReturnOffset() at Hikarian Library, so it automaticall adapts to the screen size
var keyboardIsUpⓑ = false
let specialCharacters$🅐 = ["∞"]
let YES = true, NO = false ; let 𝟭 = true, 𝟘 = false
let appⓞ = UIApplication.sharedApplication()
let fileManagerⓞ = NSFileManager.defaultManager()
let notificationCenterⓞ = NSNotificationCenter.defaultCenter()
var applicationPath$: String { return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] }
let menuControllerⓞ = UIMenuController.sharedMenuController()

enum ButtonStateTypes🅔 {
   case Enabled
   case Disabled
   case Current
}

var Δ = 0

// MARK: CUSTOM OPERATORS ————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

infix operator **{ associativity left precedence 160 } // ⬆︎⌥D
func **(base＃: Double, power＃: Double) -> Double { return pow(base＃, power＃) }

prefix operator √{} // ⌥V : can be used just √X without ()
prefix func √ (number: Double) -> Double { return sqrt(number) }

prefix operator ¬{} // ⌥6
prefix func ¬ (expressionⓑ: Bool) -> Bool { return !expressionⓑ }

prefix operator ◊{} // ⬆︎⌥V - Need to find a better character for this
prefix func ◊<T> (objectⓞ: T?) -> Bool { return objectⓞ == nil ?  false : YES }

infix operator ‡{ precedence 130 } // ⬆︎⌥T
func ‡<T: Equatable> (object1: T, object2: T) -> Bool { return object1 != object2 }

prefix operator •{} // ⬆︎ + ⌥ + 3
prefix func •<T> (pointer: UnsafeMutablePointer<T>) -> T { return pointer.memory }

infix operator ~ { associativity left precedence 160 } // ⌥Ñ
func ~<T> (pointer: UnsafeMutablePointer<T>, newValue: T ) { pointer.memory = newValue }
func pointerTo<T>(inout objectⓞ: T) -> UnsafeMutablePointer<T> { return withUnsafeMutablePointer(&objectⓞ) {UnsafeMutablePointer<T>($0) } } // THIS FUNCTION IS T-H-E • S-H-I-T!!  TOOK ME SOME TIME TO FIGURE OUT, but now I can get a pointer to a value-type!! 😀👍🏼👋🏻 (must post-cast)


// MAR: INTERNAL & TYPE EXTENSIONS ————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

extension Optional {
   func isNotNilⓑ() -> Bool { return self != nil }
   func isNilⓑ() -> Bool { return self == nil }
   mutating func setNil() { self = nil }
}

extension Int {
   static func random＃(min＃: Int = 0, max＃: Int) -> Int { return Int(arc4random_uniform(UInt32((max＃ - min＃) + 1))) + min＃ }
   var years＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int) { return (NSCalendarUnit.Year, self) }
   var months＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int) { return (NSCalendarUnit.Month, self) }
   var days＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int){ return (NSCalendarUnit.Day, self) }
   var hours＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)  { return (NSCalendarUnit.Hour, self) }
   var minutes＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int) { return (NSCalendarUnit.Minute, self) }
   var seconds＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)  { return (NSCalendarUnit.Second, self) }
   var countToIndex＃: Int { return self - 1 }
   var formattedWith2Digits$: String { get { return String(format: "%02d", self) } }
   func isMultipleOfⓑ(number＃: Int) -> Bool { return self % number＃ == 0 }
   func isMultipleOfⓑ(number＃: Float) -> Bool { return Float(self) % number＃ == 0 }
   func isMultipleOfⓑ(number＃: CGFloat) -> Bool { return CGFloat(self) % number＃ == 0 }
   func isMultipleOfⓑ(number＃: Double) -> Bool { return Double(self) % number＃ == 0 }
}

extension Float {
   var isIntegerⓑ: Bool { return self - Float(Int(self)) == 0 }
   var formattedWith2Decimals$: String {
      let twoDecimalsFormatter = NSNumberFormatter()
      twoDecimalsFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
      twoDecimalsFormatter.minimumFractionDigits = 2 ; twoDecimalsFormatter.maximumFractionDigits = 2
      return twoDecimalsFormatter.stringFromNumber(self)!
   }
   func truncate$(numberOfDecimals＃ numberOfDecimals＃: Int) -> String {
      let twoDecimalsFormatter = NSNumberFormatter()
      twoDecimalsFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
      twoDecimalsFormatter.minimumFractionDigits = numberOfDecimals＃ ; twoDecimalsFormatter.maximumFractionDigits = numberOfDecimals＃
      return twoDecimalsFormatter.stringFromNumber(self)!
   }
   func isMultipleOfⓑ(number＃: Int) -> Bool { return self % Float(number＃) == 0 }
   func isMultipleOfⓑ(number＃: Float) -> Bool { return self % number＃ == 0 }
   func isMultipleOfⓑ(number＃: CGFloat) -> Bool { return CGFloat(self) % number＃ == 0 }
   func isMultipleOfⓑ(number＃: Double) -> Bool { return Double(self) % number＃ == 0 }
}

extension CGFloat {
   var isIntegerⓑ: Bool { return self - CGFloat(Int(self)) == 0 }
   static func random(max＃: Int) -> CGFloat { return CGFloat(arc4random() % UInt32(max＃)) }
   var formattedWith2Decimals$: String {
      let twoDecimalsFormatter = NSNumberFormatter()
      twoDecimalsFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
      twoDecimalsFormatter.minimumFractionDigits = 2 ; twoDecimalsFormatter.maximumFractionDigits = 2
      return twoDecimalsFormatter.stringFromNumber(self)!
   }
   func truncate$(numberOfDecimals＃ numberOfDecimals＃: Int) -> String {
      let twoDecimalsFormatter = NSNumberFormatter()
      twoDecimalsFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
      twoDecimalsFormatter.minimumFractionDigits = numberOfDecimals＃ ; twoDecimalsFormatter.maximumFractionDigits = numberOfDecimals＃
      return twoDecimalsFormatter.stringFromNumber(self)!
   }
   func isMultipleOfⓑ(number＃: Int) -> Bool { return self % CGFloat(number＃) == 0 }
   func isMultipleOfⓑ(number＃: Float) -> Bool { return self % CGFloat(number＃) == 0 }
   func isMultipleOfⓑ(number＃: CGFloat) -> Bool { return self % number＃ == 0 }
   func isMultipleOfⓑ(number＃: Double) -> Bool { return Double(self) % number＃ == 0 }
}

extension Double {
   var isIntegerⓑ: Bool { return self - Double(Int(self)) == 0 }
   var formattedWith2Decimals$: String {  // must investigate combining this with fixed digit in number as well
      let twoDecimalsFormatter = NSNumberFormatter()
      twoDecimalsFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
      twoDecimalsFormatter.minimumFractionDigits = 2 ; twoDecimalsFormatter.maximumFractionDigits = 2
      return twoDecimalsFormatter.stringFromNumber(self)!
   }
   func truncate$(numberOfDecimals＃ numberOfDecimals＃: Int) -> String {
      let twoDecimalsFormatter = NSNumberFormatter()
      twoDecimalsFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
      twoDecimalsFormatter.minimumFractionDigits = numberOfDecimals＃ ; twoDecimalsFormatter.maximumFractionDigits = numberOfDecimals＃
      return twoDecimalsFormatter.stringFromNumber(self)!
   }
   func isMultipleOfⓑ(number＃: Int) -> Bool { return self % Double(number＃) == 0 }
   func isMultipleOfⓑ(number＃: Float) -> Bool { return self % Double(number＃) == 0 }
   func isMultipleOfⓑ(number＃: CGFloat) -> Bool { return CGFloat(self) % number＃ == 0 }
   func isMultipleOfⓑ(number＃: Double) -> Bool { return self % number＃ == 0 }
}

extension CGRect { // this shortens A LOT the code for editing CGRects * * * *
   mutating func setValues(xⓖ xⓖ: CGFloat? = nil, ＋Xⓑ: Bool = false, yⓖ: CGFloat? = nil, ＋Yⓑ: Bool = false, widthⓖ: CGFloat? = nil, ＋Wⓑ: Bool = false, heightⓖ: CGFloat? = nil, ＋Hⓑ: Bool = false) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = xⓖ.isNilⓑ() ? origin.x : ( ＋Xⓑ ? origin.x + xⓖ! : xⓖ! )
      _yⓖ = yⓖ.isNilⓑ() ? origin.y : ( ＋Yⓑ ? origin.y + yⓖ! : yⓖ! )
      _widthⓖ = widthⓖ.isNilⓑ() ? width : ( ＋Wⓑ ? width + widthⓖ! : widthⓖ! )
      _heightⓖ = heightⓖ.isNilⓑ() ? height : ( ＋Hⓑ ? height + heightⓖ! : heightⓖ! )
      self = CGRectMake(_xⓖ, _yⓖ, _widthⓖ, _heightⓖ)
   }
}

internal extension Array {

   var isNotEmptyⓑ: Bool { return !isEmpty }
   var maxIndex＃: Int { return count - 1 }
 
   var second: Element? { return self[1] }
   var third: Element?  { return self[2] }
   var lastElement: Element? {
      get { return last }
      set { self[maxIndex＃] = newValue! }
   }
   var penultimate: Element? {
      if count > 1 { return self[maxIndex＃ - 1] }
      return nil
   }
   
   subscript(start＃: Int, end＃: Int) -> Array<Element> {
      let maxEnd＃ = min(maxIndex＃, end＃)
      var output🅐: Array<Element> = []
      for index＃ in 0...maxEnd＃ { output🅐.append(self[index＃]) }
//      for var index＃ = 0 ; index＃ <= maxEnd＃ ; index＃ += 1 { output🅐.append(self[index＃]) }
      return output🅐
   }

   mutating func clear() { removeAll() }
   mutating func pushElement(element: Element) { append(element) }
   mutating func popElement() -> Element { return removeLast() }
   mutating func popElements(numberOfElements＃ numberOfElements＃: Int, FIFOⓑ: Bool = false) -> [Element] {
      var output🅐 = [Element](); var counter = 1
      for element﹖ in reverse() {
         output🅐.append(element﹖)
         counter += 1; if counter > numberOfElements＃ { break }
      }
      return FIFOⓑ ? output🅐.reverse() : output🅐
   }
   mutating func removeLast(numberOfElements＃ numberOfElements＃: Int) { for _ in 1...numberOfElements＃ { removeLast() } }
   mutating func pluck(atIndex itemIndex＃: Int = 0) -> Element { return removeAtIndex(itemIndex＃) }
   func last·n·Elements🅐(numberOfElements＃ numberOfElements＃: Int) -> [Element] {
      var outputArray🅐 = [Element]()
      for elementIndex＃ in (count - numberOfElements＃)..<count { outputArray🅐.append(self[elementIndex＃]) }
//      for (var elementIndex＃ = count - numberOfElements＃ ; elementIndex＃ < count ; elementIndex＃++) { outputArray🅐.append(self[elementIndex＃]) }
      return outputArray🅐
   }
   // func pickRandomElement() -> Element
   // func pluckRandomElement() -> Element


   func elemetsContaingString＃<T>(string$ string$: String, segment＃＃🅣: (start＃: Int, end＃: Int)? = nil, componentNumberOrFirstOrLast﹖: T? = nil) -> Int? { // only for [String]
      if count == 0 { return 0 }
      if !(HK＋.getTypeName$(self) == "Array<String>") { return nil } // cutre way to check for Array Type
      var counter＃ = 0
      if segment＃＃🅣 == nil {
         for element﹖ in self {
            let element$ = element﹖ as! String
            if element$.rangeOfString(string$) != nil { counter＃ += 1 }
         }
      } else {
         if componentNumberOrFirstOrLast﹖.isNilⓑ() {
            for element﹖ in self {
               let element$ = element﹖ as! String
               if element$[segment＃＃🅣!.start＃, segment＃＃🅣!.end＃] == string$ { counter＃ += 1 }
            }
         } else {
            switch HK＋.getTypeName$(componentNumberOrFirstOrLast﹖!) {
               case "Int":
                  for element﹖ in self {
                     let element$ = element﹖ as! String
                     let elementComponent$ = element$.componentsSeparatedByString(".")[componentNumberOrFirstOrLast﹖ as! Int]
                     if elementComponent$[segment＃＃🅣!.start＃, segment＃＃🅣!.end＃] == string$ { counter＃ += 1 }
                  }
               case "String":
                  for element﹖ in self {
                     let element$ = element﹖ as! String
                     var elementComponent$: String
                        switch (componentNumberOrFirstOrLast﹖ as! String).lowercaseString.trimmed$ {
                           case "first": elementComponent$ = element$.componentsSeparatedByString(".").first!
                           case "last": elementComponent$ = element$.componentsSeparatedByString(".").last!
                           default: return nil
                      }
                     if elementComponent$[segment＃＃🅣!.start＃, segment＃＃🅣!.end＃] == string$ { counter＃ += 1 }
                  }
               default: return nil
            }
         }
      }
      return counter＃
   }
   
}

extension PHFetchResult {
   var isEmptyⓑ: Bool { return count == 0 }
   var isNotEmptyⓑ: Bool { return count != 0 }
}


internal extension Dictionary { mutating func clear() { removeAll() } }

extension Character {
   
   var isDecDigitⓑ: Bool { return self >= "0" && self <= "9" }
   var isHexDigitⓑ: Bool { return isDecDigitⓑ || (self >= "a" && self <= "f") || (self >= "A" && self <= "F") }
   
   // This is a way to obtain the ASCII code of a single-character string, but it's not needed to evaluate a character with operators < and >
   // let charUnicodeScalar = String(char).lowercaseString.unicodeScalars
   // var digitASCIICode = charUnicodeScalar[charUnicodeScalar.startIndex].value
   
}

class HKString＋ {
   
   func spaces$(length＃: Int) -> String {
      if length＃ == 0 { return "" }
      var spaces$ = ""
      for _ in 1...length＃ { spaces$ += " " }
      return spaces$
   }

}

extension String {

   var isEmptyⓑ: Bool { return self == "" }
   var length＃: Int { return characters.count }
   var maxIndex＃: Int  { return characters.count - 1 }
   var lastCharacter$: String { return self == "" ? "" : self[self.maxIndex＃]! }
   
   subscript(index＃: Int) -> String? { // Returns the character at the index
      if length＃ == 0 { return nil }
      return substringWithRange(startIndex.advancedBy(index＃)...startIndex.advancedBy(index＃))
   }
   
   subscript(start＃: Int, end＃: Int) -> String? { // Returns the substring in the given Int range. Max-overflow-proof
      let maxEnd＃ = min(maxIndex＃, end＃)
      if start＃ < 0 || start＃ > maxEnd＃ { return nil }
      return substringWithRange(startIndex.advancedBy(start＃)...startIndex.advancedBy(maxEnd＃))
   }
   
   
   func left$(length＃: Int) -> String { if length＃ <= length＃ { return self[0, length＃-1]! } else { return self } }
   func right$(length＃: Int) -> String { if length＃ <= length＃ { return self[length＃ - length＃, length＃-1]! } else { return self } }
   
   var localized$: String { return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "") }
   var capitalizedFirst$: String  { return String(characters.prefix(1)).uppercaseString + String(characters.dropFirst()) }
   mutating func capitalizeFirst() { replaceRange(startIndex...startIndex, with: String(self[startIndex]).uppercaseString) }
   var capitalizedAfterCommas$: String {
      var output$ = String()
      let componentsMaxIndex＃ = self.componentsSeparatedByString(",").maxIndex＃
      for (index＃, component$) in self.componentsSeparatedByString(",").enumerate() {
         let trimmedComponent$ = component$.trimmed$.capitalizedFirst$
         output$ += trimmedComponent$ + (index＃ == componentsMaxIndex＃ ? "" : ", ")
      }
      return output$
   }
   
   
   var trimmed$: String { return (self as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) }
   func removeCharacter$(character$: String) -> String { return stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: character$)) }
   func replaceCharacter$(out$: String, new$: String) -> String { return stringByReplacingOccurrencesOfString(out$, withString: new$) }
   
   var toDate㊐: NSDate { let dateFormatter = NSDateFormatter(); dateFormatter.dateFormat = "YYYY/MM/dd"; return dateFormatter.dateFromString(self)! }
   var toTime㊐: NSDate { let timeFormatter = NSDateFormatter(); timeFormatter.dateFormat = "HH:mm"; return timeFormatter.dateFromString(self)! }
   var yearComponent$: String? { // takes format "YYYY/MM/DD"
      if length＃ != 10 { return nil }
      return self[0, 3]
   }
   var monthComponent$: String? { // takes format "YYYY/MM/DD"
      if length＃ != 10 { return nil }
      return self[5, 6]
   }
   var dayComponent$: String? { // takes format "YYYY/MM/DD"
      if length＃ != 10 { return nil }
      return self[8, 9]
   }
   func isWeekEndⓑ() -> Bool { if HKDate＋.WeekDayFromLocalizedString$🅔🅓[self] == .Saturday || HKDate＋.WeekDayFromLocalizedString$🅔🅓[self] == .Sunday { return true } else { return false } }
   func isWeekDayⓑ() -> Bool { if isWeekEndⓑ() { return false } else { return true } }

   var int＃: Int? { return Int(self) ?? nil }
   var double＃: Double? { return Double(self) ?? nil }
   var float＃: Float? { return Float(self) ?? nil }
   var CGFloatⓖ: CGFloat? { return float＃.isNilⓑ() ? nil : CGFloat(float＃!) }
   var intFromHexString＃: Int? { // gets a string representing an hexadecimal number in the standard format 0x0000..., and returns its Integer value
      let hexDigits$🅓 = ["0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15]
      func formatIsCorrectⓑ() -> Bool {
         var veredictⓑ: Bool = true
         for char$ in characters { if !char$.isHexDigitⓑ { veredictⓑ = false ; break } }
         return veredictⓑ
      }
      let return＃ = hexDigits$🅓[self[0]!]! * 16 + hexDigits$🅓[self[1]!]!
      return formatIsCorrectⓑ() ? return＃ : nil
   }
   func toChar$ (position＃: Int = 0) -> Character? { return position＃ > length＃ - 1 ? nil : Character(self[position＃]!) } // returns the requested character in a string converted to type Character

   var components$🅐: [String] { return componentsSeparatedByString(".") }
   var firstComponent$: String? { return componentsSeparatedByString(".").first }
   var lastComponent$: String? { return componentsSeparatedByString(".").last }
   
}

//   var GPX㊐: NSDate? { // GPS Exchange format
//      let dateFormatterⓞ = NSDateFormatter()
//      dateFormatterⓞ.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
//      return dateFormatterⓞ.dateFromString(self)
//   }


// MARK:  GENERAL PURPOSE, CLASS MANAGEMENT & NSObject EXTENSIONS —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class HK＋ {
   
   class func getTypeName$<T>(object$﹖: T) -> String { return String(object$﹖.dynamicType) } // やっと当たった。これはいいのだ！!
   
   func postNotification(notification$ notification$: String, senderⓞ: AnyObject? = nil) {  NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: notification$, object: senderⓞ)) }
   
   func registerObserver(observerⓞ observerⓞ: AnyObject, handlerƒ$: Selector, notification$: String, senderⓞ: AnyObject? = nil) { // if the handler has parameters its name must be suffixed with ":"
      NSNotificationCenter.defaultCenter().addObserver(observerⓞ, selector: handlerƒ$, name: notification$, object: senderⓞ) }
   
   func unregisterObserver(Oobserverⓞ observerⓞ: AnyObject, notification$: String, senderⓞ: AnyObject? = nil) {  NSNotificationCenter.defaultCenter().removeObserver(observerⓞ, name: notification$, object: senderⓞ) }
   
   static var deviceLanguage$＋: String { get { return NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) as! String } }
   static var deviceCountry$＋: String { get { return  NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as! String } }
}


/* CREATING A COPY OF AN INSTANCE
 
 class RootClass {
   func copy() -> AnyObject! {
      if let objectWithCopyProtocolⓅ = ((self as AnyObject) as? NSCopying) { return objectWithCopyProtocolⓅ.copyWithZone(nil) }
      else {
         assert(false, "This class doesn't implement NSCopying")
      return nil
      }
   }
 }

 
 class myClass : RootClass, NSCopying { @objc func copyWithZone(zone: NSZone) -> AnyObject { return myClass() } }
 
 var myVar = myClass()
 let copiedVar = myVar.copy()
 
 
 */

extension NSObject { var className$: String { return self.dynamicType.description().componentsSeparatedByString(".").last!.removeCharacter$("_") } }

/* CLASS MANAGEMENT


// NSObject EXTENSION?? ??? ?? ?? ?? ?? ?? ?? with function to return class name

Object -> Class : CANNOT BE USED AS TYPES => USELESS
objectⓞ.self
dump(objectⓞ)

Class -> String
objectⓞ.dynamicType.description()
objectⓞ.classForCoder.description()
objectⓞ.classForKeyedArchiver?.description()
_stdlib_getDemangledTypeName(objectⓞ)
_stdlib_getDemangledTypeName(objectⓞ).componentsSeparatedByString(".").last!

String -> Class
let createdClass = NSClassFromString("UIView") as! UIView.Type // This creates an UIView
let theView: UIView = createdClass.init() // Should now give you a new objectⓞ

more research to be made at:
http://stackoverflow.com/questions/24030814/swift-language-nsclassfromstring

*/

// MARK:  THREAD-RELATED FUNCTIONS ——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

enum QueueTypes🅔 {
   case Concurrent
   case Serial
}

enum QueueQOS🅔: UInt {
   case Unspecified = 0x00
   case Default = 0x15
   case Background = 0x09
   case Utility = 0x11
   case Initiated = 0x19
   case Interactive = 0x21
}

enum QueuePriorities🅔 {
   case Default
   case Background
   case Low
   case High
}

class HKThreading＋ {

   enum ThreadDispatchModes🅔 {
      case Synchronous
      case Asynchronous
   }
   
   class func LAUNCH_THREAD_MAIN_Q(dispatchMode🅔 dispatchMode🅔: ThreadDispatchModes🅔 = .Asynchronous, delayInSeconds＃: NSTimeInterval? = nil, bodyƒ: () -> (), completionƒ: (() -> ())? = nil) {
      if delayInSeconds＃.isNilⓑ() { if dispatchMode🅔 == .Synchronous { dispatch_sync(dispatch_get_main_queue()) { bodyƒ(); completionƒ?() } } else { dispatch_async(dispatch_get_main_queue()) { bodyƒ(); completionƒ?() } }
      } else { dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds＃!*Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { bodyƒ(); completionƒ?() } }
   }

   class func LAUNCH_THREAD_GLOBAL_Q(dispatchMode🅔 dispatchMode🅔: ThreadDispatchModes🅔 = .Asynchronous, priority🅔: QueuePriorities🅔? = .Default, qualityOfService🅔: QueueQOS🅔? = nil, delayInSeconds＃: NSTimeInterval? = nil, bodyƒ: () -> (), completionƒ: (() -> ())? = nil ) {
      var queue: dispatch_queue_t
      switch priority🅔! {
         case .Default: if qualityOfService🅔 == nil { queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) } else { queue = dispatch_get_global_queue(Int(qualityOfService🅔!.rawValue), 0) }
         case .Background: queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
         case .Low: queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
         case .High: queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
      }
      if delayInSeconds＃.isNilⓑ() { if dispatchMode🅔 == .Synchronous { dispatch_sync(queue) { bodyƒ(); completionƒ?() } } else { dispatch_async(queue) { bodyƒ(); completionƒ?() } }
      } else { dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds＃!*Double(NSEC_PER_SEC))), queue) { bodyƒ(); completionƒ?() } }
   }

   class func LAUNCH_THREAD_NEW_Q(dispatchMode🅔 dispatchMode🅔: ThreadDispatchModes🅔 = .Asynchronous, queueType🅔: QueueTypes🅔, queueName$: String, delayInSeconds＃: NSTimeInterval? = nil, bodyƒ: () -> (), completionƒ: (() -> ())? = nil) {
      var queue: dispatch_queue_t
      switch queueType🅔 {
         case .Concurrent: queue = dispatch_queue_create(queueName$, DISPATCH_QUEUE_CONCURRENT)
         case .Serial:  queue = dispatch_queue_create(queueName$, DISPATCH_QUEUE_SERIAL)
      }
      if delayInSeconds＃.isNilⓑ(){ if dispatchMode🅔 == .Synchronous { dispatch_sync(queue) { bodyƒ(); completionƒ } } else { dispatch_async(queue) { bodyƒ(); completionƒ } }
      } else { dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds＃!*Double(NSEC_PER_SEC))), queue) { bodyƒ(); completionƒ?() } }
   }


}

// MARK: UICOLOR EXTENSIONS ——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

extension UIColor {

   convenience init(red＃: Int, green＃: Int, blue＃: Int) {
      self.init(red: CGFloat(red＃)/255, green: CGFloat(green＃)/255, blue: CGFloat(blue＃)/255, alpha: 1.0)
   }
   convenience init(hexCode6＃$: String) { // creates a color based on a string representing an hexadecimal number in the standard format 0x0000...
      let hexCODE6＃$ = hexCode6＃$.uppercaseString
      if let red＃ = hexCODE6＃$[0,1]!.intFromHexString＃, green＃ = hexCODE6＃$[2,3]!.intFromHexString＃, blue＃ = hexCODE6＃$[4,5]!.intFromHexString＃ {
         self.init(red＃: red＃, green＃: green＃, blue＃: blue＃)
      } else { self.init() }
   }

   class var randomColorⓞ: UIColor {
      var colorCode$ = String()
      for _ in 0...5 {
         let number＃ = Int.random＃(0, max＃: 15)
         var character = String()
         switch number＃ {
            case 0: character = "0"
            case 1: character = "1"
            case 2: character = "2"
            case 3: character = "3"
            case 4: character = "4"
            case 5: character = "5"
            case 6: character = "6"
            case 7: character = "7"
            case 8: character = "8"
            case 9: character = "9"
            case 10: character = "a"
            case 11: character = "b"
            case 12: character = "c"
            case 13: character = "d"
            case 14: character = "e"
            case 15: character = "f"
            default: break
         }
         colorCode$ += character
      }
      return UIColor(hexCode6＃$: colorCode$)
   }
   
   class var randomBasicColorⓞ: UIColor {
      switch arc4random()%11 {
         case 0: return UIColor.greenColor()
         case 1: return UIColor.blueColor()
         case 2: return UIColor.orangeColor()
         case 3: return UIColor.redColor()
         case 4: return UIColor.yellowColor()
         case 5: return UIColor.purpleColor()
         case 6: return UIColor.cyanColor()
         case 7: return UIColor.brownColor()
         case 8: return UIColor.magentaColor()
         case 9: return UIColor.grayColor()
         case 10: return UIColor.lightGrayColor()
         default: return UIColor.darkGrayColor()
      }
   }
}


// MARK:  UI FUNCTIONS  ————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class HKUI＋ { // for UI stuff that are not extensions
   
   class func animation(iterations iterations＃: Int = 0, options: UIViewAnimationOptions = .CurveEaseInOut, delay＃: NSTimeInterval = 0, duration＃: NSTimeInterval, springVelocityⓖ: CGFloat? = nil, springDampingⓖ: CGFloat? = nil, mainƒ: () -> (), completionƒ: (() -> ())? = nil ) {
      if springDampingⓖ != nil && springVelocityⓖ != nil {
         UIView.animateWithDuration(duration＃, delay: delay＃, usingSpringWithDamping: springDampingⓖ!, initialSpringVelocity: springVelocityⓖ!, options: options, animations: {
            mainƒ()
         }, completion: { _ in
            if completionƒ != nil { completionƒ!() }
            if iterations＃ > 0 { animation(iterations: iterations＃ - 1, options: options, delay＃: delay＃, duration＃: duration＃, springVelocityⓖ: springVelocityⓖ, springDampingⓖ: springDampingⓖ, mainƒ: mainƒ, completionƒ: completionƒ) }
         })
      } else {
         UIView.animateWithDuration(duration＃, delay: delay＃, options: options, animations: {
            mainƒ()
         }, completion: { _ in
            if completionƒ != nil { completionƒ!() }
            if iterations＃ > 0 { animation(iterations: iterations＃ - 1, options: options, delay＃: delay＃, duration＃: duration＃, mainƒ: mainƒ, completionƒ: completionƒ) }
         })
      }
   }

   class func animation2𝜙(options options: UIViewAnimationOptions = .CurveEaseInOut, iterations＃: Int = 0, 𝜙1Delay＃: NSTimeInterval = 0, 𝜙1Duration＃: NSTimeInterval, 𝜙1SpringVelocityⓖ: CGFloat? = nil, 𝜙1SpringDampingⓖ: CGFloat? = nil,  𝜙1ƒ: () -> (), 𝜙2Delay＃: NSTimeInterval = 0, 𝜙2Duration＃: NSTimeInterval? = nil, 𝜙2SpringVelocityⓖ: CGFloat? = nil, 𝜙2SpringDampingⓖ: CGFloat? = nil, 𝜙2ƒ: () -> (), completionƒ: (() -> ())? = nil ) {
      let 𝜙2Duration＃_ = 𝜙2Duration＃ ?? 𝜙1Duration＃
//      if 𝜙2Duration＃ == nil { 𝜙2Duration＃_ = 𝜙1Duration＃ } // DEPRECATED var MODIFIER FOR FUNCION PARAMETERES => must use auxiliary myParameter_
      if 𝜙1SpringDampingⓖ != nil && 𝜙1SpringVelocityⓖ != nil {
         UIView.animateWithDuration(𝜙1Duration＃, delay: 𝜙1Delay＃, usingSpringWithDamping: 𝜙1SpringDampingⓖ!, initialSpringVelocity: 𝜙1SpringVelocityⓖ!, options: options, animations: {
             𝜙1ƒ()
         }, completion: { _ in
            if 𝜙2SpringDampingⓖ != nil && 𝜙2SpringVelocityⓖ != nil {
               UIView.animateWithDuration(𝜙2Duration＃_, delay: 𝜙2Delay＃, usingSpringWithDamping: 𝜙2SpringDampingⓖ!, initialSpringVelocity: 𝜙2SpringVelocityⓖ!, options: options, animations: {
                  𝜙2ƒ()
               }, completion: { _ in
                  if completionƒ != nil { completionƒ!() }
                  if iterations＃ > 0 { animation2𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, completionƒ: completionƒ) }
               })
            } else {
               UIView.animateWithDuration(𝜙2Duration＃_, delay: 𝜙2Delay＃, options: options, animations: {
                  𝜙2ƒ()
               }, completion: { _ in
                  if completionƒ != nil { completionƒ!() }
                  if iterations＃ > 0 { animation2𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2ƒ: 𝜙2ƒ, completionƒ: completionƒ) }
               })
            }
         })
      } else {
         UIView.animateWithDuration(𝜙1Duration＃, delay: 𝜙1Delay＃, options: options, animations: {
             𝜙1ƒ()
         }, completion: { _ in
            if 𝜙2SpringDampingⓖ != nil && 𝜙2SpringVelocityⓖ != nil {
               UIView.animateWithDuration(𝜙2Duration＃_, delay: 𝜙2Delay＃, usingSpringWithDamping: 𝜙2SpringDampingⓖ!, initialSpringVelocity: 𝜙2SpringVelocityⓖ!, options: options, animations: {
                  𝜙2ƒ()
               }, completion: { _ in
                  if completionƒ != nil { completionƒ!() }
                  if iterations＃ > 0 { animation2𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2ƒ: 𝜙2ƒ, completionƒ: completionƒ) }
               })
            } else {
               UIView.animateWithDuration(𝜙2Duration＃_, delay: 𝜙2Delay＃, options: options, animations: {
                  𝜙2ƒ()
               }, completion: { _ in
                  if completionƒ != nil { completionƒ!() }
                  if iterations＃ > 0 { animation2𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙1Duration＃, 𝜙2ƒ: 𝜙2ƒ, completionƒ: completionƒ) }
               })
            }
         })
      }
   }

   class func animation3𝜙(options options: UIViewAnimationOptions = .CurveEaseInOut, iterations＃: Int = 0, 𝜙1Delay＃: NSTimeInterval = 0, 𝜙1Duration＃: NSTimeInterval, 𝜙1SpringVelocityⓖ: CGFloat? = nil, 𝜙1SpringDampingⓖ: CGFloat? = nil,  𝜙1ƒ: () -> (), 𝜙2Delay＃: NSTimeInterval = 0, 𝜙2Duration＃: NSTimeInterval? = nil, 𝜙2SpringVelocityⓖ: CGFloat? = nil, 𝜙2SpringDampingⓖ: CGFloat? = nil, 𝜙2ƒ: () -> (), 𝜙3Delay＃: NSTimeInterval = 0, 𝜙3Duration＃: NSTimeInterval? = nil, 𝜙3SpringVelocityⓖ: CGFloat? = nil, 𝜙3SpringDampingⓖ: CGFloat? = nil, 𝜙3ƒ: () -> (), completionƒ: (() -> ())? = nil ) {
      let 𝜙2Duration＃_ = 𝜙2Duration＃ ?? 𝜙1Duration＃
      let 𝜙3Duration＃_ = 𝜙2Duration＃ ?? 𝜙1Duration＃
      if 𝜙1SpringVelocityⓖ != nil && 𝜙1SpringDampingⓖ != nil {
         UIView.animateWithDuration(𝜙1Duration＃, delay: 𝜙1Delay＃, usingSpringWithDamping: 𝜙1SpringDampingⓖ!, initialSpringVelocity: 𝜙1SpringVelocityⓖ!, options: options, animations: { // 1 ? ?
             𝜙1ƒ()
         }, completion: { _ in
            if 𝜙2SpringVelocityⓖ != nil && 𝜙2SpringDampingⓖ != nil {
               UIView.animateWithDuration(𝜙2Duration＃_, delay: 𝜙2Delay＃, usingSpringWithDamping: 𝜙2SpringDampingⓖ!, initialSpringVelocity: 𝜙2SpringVelocityⓖ!, options: options, animations: { // 1 1 ?
                  𝜙2ƒ()
               }, completion: { _ in
                  if 𝜙3SpringVelocityⓖ != nil && 𝜙3SpringDampingⓖ != nil {
                     UIView.animateWithDuration(𝜙3Duration＃_, delay: 𝜙3Delay＃, usingSpringWithDamping: 𝜙3SpringDampingⓖ!, initialSpringVelocity: 𝜙3SpringVelocityⓖ!, options: options, animations: { // 1 1 1
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙3ƒ, completionƒ: completionƒ) }
                     })
                  } else {
                     UIView.animateWithDuration(𝜙3Duration＃_, delay: 𝜙3Delay＃, options: options, animations: { // 1 1 0
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙3ƒ, completionƒ: completionƒ) }
                     })
                  }
               })
            } else {
               UIView.animateWithDuration(𝜙2Duration＃_, delay: 𝜙2Delay＃, options: options, animations: { // 1 0 ?
                  𝜙2ƒ()
               }, completion: { _ in
                  if 𝜙3SpringVelocityⓖ != nil && 𝜙3SpringDampingⓖ != nil {
                     UIView.animateWithDuration(𝜙3Duration＃_, delay: 𝜙3Delay＃, usingSpringWithDamping: 𝜙3SpringDampingⓖ!, initialSpringVelocity: 𝜙3SpringVelocityⓖ!, options: options, animations: { // 1 0 1
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙3ƒ, completionƒ: completionƒ) }
                     })
                  } else {
                     UIView.animateWithDuration(𝜙3Duration＃_, delay: 𝜙3Delay＃, options: options, animations: { // 1 0 0
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙3ƒ, completionƒ: completionƒ) }
                     })
                  }
               })
            }
         })
      } else {
         UIView.animateWithDuration(𝜙1Duration＃, delay: 𝜙1Delay＃, options: options, animations: { // 0 ? ?
             𝜙1ƒ()
         }, completion: { _ in
            if 𝜙2SpringVelocityⓖ != nil && 𝜙2SpringDampingⓖ != nil {
               UIView.animateWithDuration(𝜙2Duration＃_, delay: 𝜙2Delay＃, usingSpringWithDamping: 𝜙2SpringDampingⓖ!, initialSpringVelocity: 𝜙2SpringVelocityⓖ!, options: options, animations: { // 0 1 ?
                  𝜙2ƒ()
               }, completion: { _ in
                  if 𝜙3SpringVelocityⓖ != nil && 𝜙3SpringDampingⓖ != nil {
                     UIView.animateWithDuration(𝜙3Duration＃_, delay: 𝜙3Delay＃, usingSpringWithDamping: 𝜙3SpringDampingⓖ!, initialSpringVelocity: 𝜙3SpringVelocityⓖ!, options: options, animations: { // 0 1 1
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙1ƒ, completionƒ: completionƒ) }
                     })
                  } else {
                     UIView.animateWithDuration(𝜙3Duration＃_, delay: 𝜙3Delay＃, options: options, animations: { // 0 1 0
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙1ƒ, completionƒ: completionƒ) }
                     })
                  }
               })
            } else {
               UIView.animateWithDuration(𝜙2Duration＃_, delay: 𝜙2Delay＃, options: options, animations: { // 0 0 ?
                  𝜙2ƒ()
               }, completion: { _ in
                  if 𝜙3SpringVelocityⓖ != nil && 𝜙3SpringDampingⓖ != nil {
                     UIView.animateWithDuration(𝜙3Duration＃_, delay: 𝜙3Delay＃, usingSpringWithDamping: 𝜙3SpringDampingⓖ!, initialSpringVelocity: 𝜙3SpringVelocityⓖ!, options: options, animations: { // 0 0 1
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙1ƒ, completionƒ: completionƒ) }
                     })
                  } else {
                     UIView.animateWithDuration(𝜙3Duration＃_, delay: 𝜙3Delay＃, options: options, animations: { // 0 0 0
                        𝜙3ƒ()
                     }, completion: { _ in
                        if completionƒ != nil { completionƒ!() }
                        if iterations＃ > 0 { animation3𝜙(options: options, iterations＃: iterations＃ - 1, 𝜙1Delay＃: 𝜙1Delay＃, 𝜙1Duration＃: 𝜙1Duration＃, 𝜙1SpringVelocityⓖ: 𝜙1SpringVelocityⓖ, 𝜙1SpringDampingⓖ: 𝜙1SpringDampingⓖ,  𝜙1ƒ:  𝜙1ƒ, 𝜙2Delay＃: 𝜙2Delay＃, 𝜙2Duration＃: 𝜙2Duration＃_, 𝜙2SpringVelocityⓖ: 𝜙2SpringVelocityⓖ, 𝜙2SpringDampingⓖ: 𝜙2SpringDampingⓖ, 𝜙2ƒ: 𝜙2ƒ, 𝜙3Delay＃: 𝜙3Delay＃, 𝜙3Duration＃: 𝜙3Duration＃_, 𝜙3SpringVelocityⓖ: 𝜙3SpringVelocityⓖ, 𝜙3SpringDampingⓖ: 𝜙3SpringDampingⓖ, 𝜙3ƒ:  𝜙1ƒ, completionƒ: completionƒ) }
                     })
                  }
               })
            }
         })
      }
   }

   class func Blink(inout objects objects: [UIView], blinks＃: Int) { animation2𝜙(iterations＃: blinks＃, 𝜙1Duration＃: 0.02,  𝜙1ƒ: { for objectⓞ in objects { objectⓞ.alpha = 0 } }, 𝜙2ƒ: { for objectⓞ in objects { objectⓞ.alpha = 1 } }) }
   
}

// MARK: UIVIEW EXTENSIONS ————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

extension UIView {
   
   var rootView: UIView { return window! }
   var absoluteOriginⓖ²: CGPoint { return superview!.convertPoint(frame.origin, toView: window) }
   var visibleⓑ: Bool { get { return !hidden } set { hidden = !newValue } }
   var transparentⓑ: Bool { return alpha == 0 }
   var opacityⓖ: CGFloat { get { return alpha } set { alpha = newValue } }
   var opaqueⓑ: Bool { return alpha != 0 }
   func transparent() { alpha = 0 }
   func opaque() { alpha = 1 }
   
   var activeControlⓞ: UIResponder? { return findActiveControlⓞ() }
   private func findActiveControlⓞ() -> UIResponder? {
      if isFirstResponder() { return self }
      for subView in subviews { if let responder = subView.findActiveControlⓞ() { return responder } }
      return nil
   }
   
   func setFrame(xⓖ xⓖ: CGFloat? = nil, ＋Xⓑ: Bool = false, yⓖ: CGFloat? = nil, ＋Yⓑ: Bool = false, widthⓖ: CGFloat? = nil, ＋Wⓑ: Bool = false, heightⓖ: CGFloat? = nil, ＋Hⓑ: Bool = false) {
      var _xⓖ: CGFloat, _yⓖ: CGFloat, _widthⓖ : CGFloat, _heightⓖ: CGFloat
      _xⓖ = xⓖ.isNilⓑ() ? frame.origin.x : ( ＋Xⓑ ? frame.origin.x + xⓖ! : xⓖ! )
      _yⓖ = yⓖ.isNilⓑ() ? frame.origin.y : ( ＋Yⓑ ? frame.origin.y + yⓖ! : yⓖ! )
      _widthⓖ = widthⓖ.isNilⓑ() ? frame.width : ( ＋Wⓑ ? frame.width + widthⓖ! : widthⓖ! )
      _heightⓖ = heightⓖ.isNilⓑ() ? frame.height : ( ＋Hⓑ ? frame.height + heightⓖ! : heightⓖ! )
      frame = CGRectMake(_xⓖ, _yⓖ, _widthⓖ, _heightⓖ)
   }
   
   func centerInObjectFrame(object﹖ object﹖: AnyObject) {
      if let castViewⓞ = object﹖ as? UIView {
         let containerFrameⓖ⁴ = castViewⓞ.frame
         let Wⓖ = containerFrameⓖ⁴.width, Hⓖ = containerFrameⓖ⁴.height
         var wⓖ = frame.width, hⓖ = frame.height
         if wⓖ > Wⓖ || hⓖ > Wⓖ {
            let wExcessⓖ = wⓖ - Wⓖ, hExcessⓖ = hⓖ - Wⓖ
            if wExcessⓖ > hExcessⓖ {
               let scaleFactorⓖ = wⓖ / Wⓖ
               wⓖ = Wⓖ
               hⓖ = hⓖ / scaleFactorⓖ
            } else {
               let scaleFactorⓖ = hⓖ / Hⓖ
               hⓖ = Hⓖ
               wⓖ = wⓖ / scaleFactorⓖ
            }
         }
         frame = CGRect(x: (Wⓖ - wⓖ) / 2, y: (Hⓖ - hⓖ) / 2, width: wⓖ, height: hⓖ)
      }
   }
   
   func centerAroundObjectBounds(object﹖ object﹖: AnyObject) {
      if let castViewⓞ = object﹖ as? UIView {
         let containedBoundsⓖ⁴ = castViewⓞ.bounds
         let wⓖ = containedBoundsⓖ⁴.width, hⓖ = containedBoundsⓖ⁴.height
         let Wⓖ = frame.width, Hⓖ = frame.height
         if Wⓖ < wⓖ || Hⓖ < hⓖ { return }
         frame = CGRect(x: -(Wⓖ - wⓖ) / 2, y: -(Hⓖ - hⓖ) / 2, width: Wⓖ, height: Hⓖ)
      }
   }
   
   func positionInPoint(xⓖ pointXⓖ: CGFloat, yⓖ pointYⓖ: CGFloat) {
      let xⓖ = pointXⓖ - self.frame.width / 2
      let yⓖ = pointYⓖ - self.frame.height / 2
      self.setFrame(xⓖ: xⓖ, yⓖ: yⓖ)
   }
   
   func positionInPoint(pointⓖ²: CGPoint) {
      let xⓖ = pointⓖ².x - self.frame.width / 2
      let yⓖ = pointⓖ².y - self.frame.height / 2
      self.setFrame(xⓖ: xⓖ, yⓖ: yⓖ)
   }
   
   func pointIsInFrameⓑ(xⓖ pointXⓖ: CGFloat, yⓖ pointYⓖ: CGFloat) -> Bool { return ( pointXⓖ > frame.origin.x && pointXⓖ < frame.origin.x + frame.width && pointYⓖ > frame.origin.y && pointYⓖ < frame.origin.y + frame.height) }
   
   func containsPointⓑ(pointⓖ²: CGPoint) -> Bool { return self.frame.contains(pointⓖ²) }
   
   func dismissKeyboard() { endEditing(true) }
   
   func rasterizeToImage() -> UIImage {
      UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
      layer.renderInContext(UIGraphicsGetCurrentContext()!) // this like and the next are equivalent
      //      drawViewHierarchyInRect(bounds, afterScreenUpdates: YES)  // this like and the previous are equivalent
      let snapshot = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return snapshot
   }
   func rasterizeToImageView() -> UIImageView { return UIImageView(image: rasterizeToImage()) }
   func rasterizeToView() -> UIView { return snapshotViewAfterScreenUpdates(true) }
   
   internal func objectWithContextID(contextID$: String) -> HasContextID$Ⓟ? {
      for subView in subviews { if let objectⓞ = subView as? HasContextID$Ⓟ where objectⓞ.contextID$ == contextID$ { return objectⓞ } }
      return nil
   }
   internal func objectsWithContextIDs🅐(contextIDs$🅐: [String]) -> [HasContextID$Ⓟ]? {
      var output🅐 = [HasContextID$Ⓟ]()
//      for contextID$ in contextIDs$🅐 { for subView in subviews { if let objectⓞ = subView as? HasContextID$ { if let objectContextID$ = objectⓞ.contextID$ where objectContextID$ == contextID$ { output🅐.append(objectⓞ) } } } }
      for contextID$ in contextIDs$🅐 { for subView in subviews { if let objectⓞ = subView as? HasContextID$Ⓟ where objectⓞ.contextID$ == contextID$ { output🅐.append(objectⓞ) } } }
      return output🅐.count == 0 ? nil : output🅐
   }
   internal func objectWithContextualInfo(contextualInfo$: String) -> HasContextualInfo$Ⓟ? {
      for subView in subviews { if let objectⓞ = subView as? HasContextualInfo$Ⓟ { if objectⓞ.contextualInfo$! == contextualInfo$ { return objectⓞ }} }
      return nil
   }
  
   func bringSubviewsToFront(subviews: [UIView]) { for subview in subviews { bringSubviewToFront(subview) } }
   
   func slideUpForKeyboard(notification notification: NSNotification, duration: NSTimeInterval = 0.4) { // if the firstResponder is a UITextField of a UITextView, it slides the view up by the height of the keyboard and returns it
      if let keyboardSizeⓖ² = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
         keyboardHeightⓖ = keyboardSizeⓖ².height
         if let responder = activeControlⓞ as? UIView {
            if (responder.className$ == "UITextField") || (responder.className$ == "UITextView") || (responder.className$ == "HikarianUITextView") || (responder.className$ == "HikarianUITextView")  || (responder.className$ == "UISearchBar") {
               if responder.absoluteOriginⓖ².y + responder.frame.height >= (responder.window!.frame.height - keyboardHeightⓖ) {
                  UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { self.frame =  CGRect(x: self.frame.origin.x, y: self.frame.origin.y - keyboardHeightⓖ, width: self.frame.width, height: self.frame.height) }, completion: nil)
                  keyboardIsUpⓑ = true
               }
            }
         }
      }
   }
   func slide(vertical verticalⓖ: CGFloat = 0, horizontalⓖ: CGFloat = 0, duration: NSTimeInterval = 0.4) { // slides a UIView by the provided offsets and with the provided duration
      UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { self.setFrame(xⓖ: self.frame.origin.x + horizontalⓖ, yⓖ: self.frame.origin.y + verticalⓖ) }, completion: nil)
   }
   
   func slideSubViewsUpForKeyboard(keyboardNotification notification: NSNotification, subViews: [UIView], duration: NSTimeInterval = 0.4) { // this is the equivalent of theUIView extension, but slides up an array of UIView inheritants
      if keyboardIsUpⓑ { return }
      if let keyboardSizeⓖ² = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
         keyboardHeightⓖ = keyboardSizeⓖ².height
         if let responder = activeControlⓞ as? UIView {
            if (responder.className$ == "UITextField") || (responder.className$ == "UITextView") || (responder.className$ == "HikarianUITextField") || (responder.className$ == "HikarianUITextView") {
               if responder.absoluteOriginⓖ².y + responder.frame.height >= (responder.window!.frame.height - keyboardHeightⓖ) {
                  UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { for subView in subViews { subView.setFrame(yⓖ: subView.frame.origin.y - keyboardHeightⓖ) } }, completion: nil)
                  keyboardIsUpⓑ = true
               }
            }
         }
      }
   }
   func slideSubViews(forKeyboardⓑ forKeyboardⓑ: Bool = false,  subViews: [UIView], verticalⓖ: CGFloat = 0, horizontalⓖ: CGFloat = 0, duration＃: NSTimeInterval = 0.4) { // THERE'S SOMETING WRONG HERE: keyboardHeight should not be always added // THIS FUNCTION IS NOT USED????
      if forKeyboardⓑ && !keyboardIsUpⓑ { return }
      for subView in subViews { UIView.animateWithDuration(duration＃, delay: 0, options: .CurveEaseOut, animations: { subView.setFrame(yⓖ: subView.frame.origin.y + keyboardHeightⓖ) }, completion: nil); if forKeyboardⓑ { keyboardIsUpⓑ = false } }
   }
   
   func fadeIn(duration duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void) = { (finishedⓑ: Bool) -> Void in }) {
      UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: { self.alpha = 1.0 }, completion: completion)
   }
   
   func fadeOut(duration duration＃: NSTimeInterval = 1.0, delay＃: NSTimeInterval = 0.0, completion: (Bool) -> Void = { (finishedⓑ: Bool) -> Void in }) {
      UIView.animateWithDuration(duration＃, delay: delay＃, options: UIViewAnimationOptions.CurveEaseIn, animations: { self.alpha = 0.0 }, completion: completion)
   }
   
   func blink(blinks＃: Int) { HKUI＋.animation2𝜙(iterations＃: blinks＃, 𝜙1Duration＃: 0.02,  𝜙1ƒ: { self.alpha = 0 }, 𝜙2ƒ: { self.alpha = 1 }) }
   
   func setBorderStyle(widthⓖ widthⓖ: CGFloat, colorⓞ: UIColor, cornerRadiusⓖ: CGFloat) {
      layer.borderWidth = widthⓖ
      layer.borderColor = colorⓞ.CGColor
      layer.cornerRadius = cornerRadiusⓖ
      layer.masksToBounds = true
   }
}

protocol HasKeyboardOberverMethodsⓅ { // this is an attempt to use a protocol as a class to invoke its keyboard methods, but there's no way to do it
   func keyboardWillHide(notification: NSNotification)
   func keyboardWillShow(notification: NSNotification)
}

extension UIScrollView {
   func scrollToTop() { self.contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top) }
}

extension UIViewController {
   
   func observe(notification$ notification$: String, handlerƒ$: Selector, senderⓞ: AnyObject? = nil) { // if the handler has parameters its name must be suffixed with ":"
      NSNotificationCenter.defaultCenter().addObserver(self, selector: handlerƒ$, name: notification$, object: senderⓞ) }
   func stopObserving(notification$ notification$: String, senderⓞ: AnyObject? = nil) {  NSNotificationCenter.defaultCenter().removeObserver(self, name: notification$, object: senderⓞ) }
   
   func popMessage(title$ title$: String = "", message$: String, buttonText$: String = "Ok", buttonStyle🅔: UIAlertActionStyle = .Default, buttonHandlerƒ: ((UIAlertAction) -> ())? = nil, completionƒ: (() -> ())? = nil) {
      let alertControllerⓞ = UIAlertController(title: title$, message: message$, preferredStyle: .Alert)
      alertControllerⓞ.addAction(UIAlertAction(title: buttonText$, style: buttonStyle🅔, handler: buttonHandlerƒ))
      presentViewController(alertControllerⓞ, animated: YES, completion: completionƒ)
   }
   
   func popMessageWithOptions(title$ title$: String = "", message$: String, button1Text$: String, button1Style🅔: UIAlertActionStyle = .Default, button1Handlerƒ: ((UIAlertAction) -> ())? = nil, button2Text$: String? = nil, button2Style🅔: UIAlertActionStyle? = nil, button2Handlerƒ: ((UIAlertAction) -> ())? = nil, button3Text$: String? = nil, button3Style🅔: UIAlertActionStyle? = nil, button3Handlerƒ: ((UIAlertAction) -> ())? = nil, completionƒ: (() -> ())? = nil) {
      // UIAlertActionStyle Sets the color and position of the option: .Default = (egrular blue, fifo from top)  | .Destructive = (regular red, fifo from top)  |  .Cancel = (bold blue, bottom)
      let alertControllerⓞ = UIAlertController(title: title$, message: message$, preferredStyle: .Alert)
      alertControllerⓞ.addAction(UIAlertAction(title: button1Text$, style: button1Style🅔, handler: button1Handlerƒ))
      if button2Text$.isNotNilⓑ() && button2Style🅔.isNotNilⓑ() { alertControllerⓞ.addAction(UIAlertAction(title: button2Text$!, style: button2Style🅔!, handler: button2Handlerƒ)) }
      if button3Text$.isNotNilⓑ() && button3Style🅔.isNotNilⓑ() { alertControllerⓞ.addAction(UIAlertAction(title: button3Text$!, style: button3Style🅔!, handler: button3Handlerƒ)) }
      presentViewController(alertControllerⓞ, animated: YES, completion: completionƒ)
   }
   
   func requestUserInput$(title$ title$: String = "", message$: String, buttonStyle🅔: UIAlertActionStyle = .Default, textPlaceholder$: String? = nil, inout outputVariable$: String, inputHandlerƒ: (handleVariable$: String) -> (), completionƒ: (() -> ())? = nil) {
      // must operate with the userInput within the optionHandler: HKUIⓞ.requestUserInput(..., inputHandlerƒ: { userInput$ in print("\n USER INPUT = \(userInput$)") })
      let alertControllerⓞ = UIAlertController(title: title$, message: message$, preferredStyle: .Alert)
      alertControllerⓞ.addTextFieldWithConfigurationHandler { textFieldⓞ in textFieldⓞ.textAlignment = .Center; if textPlaceholder$.isNotNilⓑ() { textFieldⓞ.placeholder = textPlaceholder$ } }
      alertControllerⓞ.textFields![0].keyboardType = .ASCIICapable
      alertControllerⓞ.textFields![0].keyboardAppearance = .Dark
      alertControllerⓞ.addAction(UIAlertAction(title: "Ok", style: buttonStyle🅔, handler: { alertAction in
         outputVariable$ = alertControllerⓞ.textFields!.first!.text!
         inputHandlerƒ(handleVariable$: outputVariable$)
      }))
      alertControllerⓞ.addAction(UIAlertAction(title: "Cancel", style: buttonStyle🅔, handler: nil))
      presentViewController(alertControllerⓞ, animated: YES, completion: completionƒ)
   }
   
   func slideMessageWithOptions(title$ title$: String = "", message$: String, button1Text$: String, button1Style🅔: UIAlertActionStyle = .Default, button1Handlerƒ: ((UIAlertAction) -> ())? = nil, button2Text$: String? = nil, button2Style🅔: UIAlertActionStyle = .Default, button2Handlerƒ: ((UIAlertAction) -> ())? = nil, button3Text$: String? = nil, button3Style🅔: UIAlertActionStyle = .Default, button3Handlerƒ: ((UIAlertAction) -> ())? = nil, completionƒ: (() -> ())? = nil) {
      // UIAlertActionStyle Sets the color and position of the button: .Default = (regular blue, fifo from top)  | .Destructive = (regular red, fifo from top)  |  .Cancel = (bold blue, bottom)
      let alertControllerⓞ = UIAlertController(title: title$, message: message$, preferredStyle: .ActionSheet)
      alertControllerⓞ.addAction(UIAlertAction(title: button1Text$, style: button1Style🅔, handler: button1Handlerƒ))
      if button2Text$.isNotNilⓑ() { alertControllerⓞ.addAction(UIAlertAction(title: button2Text$!, style: button2Style🅔, handler: button2Handlerƒ)) }
      if button3Text$.isNotNilⓑ() { alertControllerⓞ.addAction(UIAlertAction(title: button3Text$!, style: button3Style🅔, handler: button3Handlerƒ)) }
      presentViewController(alertControllerⓞ, animated: YES, completion: completionƒ)
   }
   
}

extension PHPhotoLibraryChangeObserver {
   func observePhotoLibrary() { PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self) }
   func stopObservingPhotoLibrary() { PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self) }
}
// since this method reqiores stpred property URL$, I'm moving it to HikrianUIWebView
//extension UIWebView { func loadURL(URL$: String) { loadRequest(NSURLRequest(URL: NSURL(string: URL$.lowercaseString)!)) } }

/*
   By default the webview will not load "unsafe" URLs, which are most of them, making it virtually useless
   to disable this limitation some settings must be added to the info.plist:
   Key NSAppTransportSecurity: Dictionary (becomes "App Transport Securtiry Settings"
      then add a subKey: "Allow Arbitrary Loads: Boolean = YES
*/


// MARK: NSDATE EXTENSIONS AND RELATED AUXILIARY FUNCTIONS ————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class HKDate＋ {
   
   static var now㊐: NSDate { return NSDate().adjustedForLocalTimeZone㊐ }
   static var nowWith6Digits$: String { get { return String(now㊐.year＃).right$(2) + "\(now㊐.month＃.formattedWith2Digits$)\(now㊐.day＃.formattedWith2Digits$)" } }
   
   static var daysOfTheWeek$🅐 = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
   static var monthsOfTheYear$🅐 = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

   enum DaysOfTheWeek🅔 {
      case Monday
      case Tuesday
      case Wednesday
      case Thursday
      case Friday
      case Saturday
      case Sunday
   }
   
   static let WeekDayFromLocalizedString$🅔🅓: [String : DaysOfTheWeek🅔] = [
      
      "MON" : .Monday, "Mon" : .Monday, "Monday" : .Monday,
      "月" : .Monday, "月曜日" : .Monday,
      
      "TUE" : .Tuesday, "Tue" : .Tuesday, "Tuesday" : .Tuesday,
      "火" : .Tuesday, "火曜日" : .Tuesday,
      
      "WED" : .Wednesday, "Wed" : .Wednesday, "Wednesday" : .Wednesday,
      "水" : .Wednesday, "水曜日" : .Wednesday,
      
      "THU" : .Thursday, "Thu" : .Thursday, "Thursday" : .Thursday,
      "木" : .Thursday, "木曜日" : .Thursday,
      
      "FRI" : .Friday, "Fri" : .Friday, "Friday" : .Friday,
      "金" : .Friday, "金曜日" : .Friday,
      
      "SAT" : .Saturday, "Sat" : .Saturday, "Saturday" : .Saturday,
      "土" : .Saturday, "土曜日" : .Saturday,

      "SUN" : .Sunday, "Sun" : .Sunday, "Sunday" : .Sunday,
      "日" : .Sunday, "日曜日" : .Sunday,
   ]

   class func IsWeekEndⓑ(dayOfTheWeek: DaysOfTheWeek🅔) -> Bool { if dayOfTheWeek == .Saturday || dayOfTheWeek == .Sunday { return true } else { return false } }
   class func IsWeekDayⓑ(dayOfTheWeek: DaysOfTheWeek🅔) -> Bool { if dayOfTheWeek != .Saturday && dayOfTheWeek != .Sunday { return true } else { return false } }

   enum MonthsOfTheYear＃🅔: Int {
      case January = 1
      case February = 2
      case March = 3
      case April = 4
      case May = 5
      case June = 6
      case July = 7
      case August = 8
      case September = 9
      case October = 10
      case November = 11
      case December = 12
   }

   class func NextWeekDay㊐(dateFrom㊐ dateFrom㊐: NSDate = NSDate(), weekDay🅔 day🅔: DaysOfTheWeek🅔) -> NSDate { // Makes no sense to make it dependent of an NSDate class or instance
      var checkDay = dateFrom㊐
      var scan＃: Int = 1
      repeat { checkDay = dateFrom㊐.addComponents㊐(days＃: scan＃); scan＃ += 1 } while checkDay.dayOfTheWeek🅔 != day🅔
      return checkDay
   }
   
}

// GLOBAL DATE OPERATORS _____________________________________________________________________________________________________

/*
   Operators to add and substract date-component units to dates
   The WrapComponents option prevents overflowing from one unit into the next larger one in case number exceeds unit capacity (ex: 25th hour)
   There doesn't seem to be any documentation on NSCalendarOptions

   USAGE:
      var tomorrow = HKDate＋.now㊐ + 1.day＃㊐🅣
      tomorrow += 1.day＃㊐🅣
      var lastYear = HKDate＋.now㊐ - 1.year＃㊐🅣
      lastYear -= 1.year＃㊐🅣
*/

func + (date㊐: NSDate, offset＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)) -> NSDate {
   return NSCalendar.currentCalendar().dateByAddingUnit(offset＃㊐🅣.unit㊐, value: offset＃㊐🅣.value＃, toDate: date㊐, options: .WrapComponents)! }
func - (date㊐: NSDate, offset＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)) -> NSDate {
   return NSCalendar.currentCalendar().dateByAddingUnit(offset＃㊐🅣.unit㊐, value: (-offset＃㊐🅣.value＃), toDate: date㊐, options: .WrapComponents)! }
func += (inout date㊐: NSDate, offset＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)) {
   date㊐ = NSCalendar.currentCalendar().dateByAddingUnit(offset＃㊐🅣.unit㊐, value: offset＃㊐🅣.value＃, toDate: date㊐, options: .WrapComponents)! }
func -= (inout date㊐: NSDate, offset＃㊐🅣: (unit㊐: NSCalendarUnit, value＃: Int)) {
   date㊐ = NSCalendar.currentCalendar().dateByAddingUnit(offset＃㊐🅣.unit㊐, value: -offset＃㊐🅣.value＃, toDate: date㊐, options: .WrapComponents)! }

/*
   This operator computes the difference between two dates and returns the result in a tuple with 6 intenger date units
   It uses the
   The operation cound also be performed with timeIntervalSince1970, but the number of days per year or month are not constant 
   so it's not an exact method
*/
func - (date1㊐: NSDate, date2㊐: NSDate) -> (years＃: Int, months＃: Int, days＃: Int, hours＃: Int, minutes＃: Int, seconds＃: Int) {
   var years＃, months＃, days＃, hours＃, minutes＃, seconds＃: Int
   var date1㊐_ = date1㊐, date2㊐_ = date2㊐
   years＃ = date1㊐_.yearsFrom＃(date2㊐_)
   switch years＃ {
      case let y＃ where y＃ > 0: date1㊐_ -= years＃.years＃㊐🅣
      case let y＃ where y＃ < 0: date2㊐_ += years＃.years＃㊐🅣
      default: break
   }
   months＃ = date1㊐_.monthsFrom＃(date2㊐_)
   switch months＃ {
      case let m＃ where m＃ > 0: date1㊐_ -= months＃.months＃㊐🅣
      case let m＃ where m＃ < 0: date2㊐_ += months＃.months＃㊐🅣
      default: break
   }
   days＃ = date1㊐_.daysFrom＃(date2㊐_)
   switch days＃ {
      case let d＃ where d＃ > 0: date1㊐_ -= days＃.days＃㊐🅣
      case let d＃ where d＃ < 0: date2㊐_ += days＃.days＃㊐🅣
      default: break
   }
   hours＃ = date1㊐_.hoursFrom＃(date2㊐_)
   switch hours＃ {
      case let h＃ where h＃ > 0: date1㊐_ -= hours＃.hours＃㊐🅣
      case let h＃ where h＃ < 0: date2㊐_ += hours＃.hours＃㊐🅣
      default: break
   }
   minutes＃ = date1㊐_.minutesFrom＃(date2㊐_)
   switch minutes＃ {
      case let m＃ where m＃ > 0: date1㊐_ -= minutes＃.minutes＃㊐🅣
      case let m＃ where m＃ < 0: date2㊐_ += minutes＃.minutes＃㊐🅣
      default: break
   }
   seconds＃ = date1㊐_.secondsFrom＃(date2㊐_)
   return (years＃, months＃, days＃, hours＃, minutes＃, seconds＃)
}


// date-comparing operators
func <= (date1㊐: NSDate, date2㊐: NSDate) -> Bool { return date1㊐.timeIntervalSince1970 <= date2㊐.timeIntervalSince1970 }
func >= (date1㊐: NSDate, date2㊐: NSDate) -> Bool { return date1㊐.timeIntervalSince1970 >= date2㊐.timeIntervalSince1970 }
func < (date1㊐: NSDate, date2㊐: NSDate) -> Bool { return date1㊐.timeIntervalSince1970 < date2㊐.timeIntervalSince1970 }
func > (date1㊐: NSDate, date2㊐: NSDate) -> Bool { return date1㊐.timeIntervalSince1970 > date2㊐.timeIntervalSince1970 }
func == (date1㊐: NSDate, date2㊐: NSDate) -> Bool { return date1㊐.timeIntervalSince1970 == date2㊐.timeIntervalSince1970 }


/* HERE'S ANOTHER METHOD TO COMPARE DATES, BUT DOES NOT APPLY TO <= OR >=

    let comparisonResultⓞ = date1㊐.compare(date2㊐)
    switch comparisonResultⓞ {
      case .OrderedAscending: // date1㊐ < date2㊐
      case .OrderedSame: // date1㊐ = date2㊐
      case .OrdeDescending: // date1㊐ > date2㊐
    }

   return date1㊐.compare(date2㊐) == .OrderedAscending
*/

// __________________________________________________________________________________________________________________________________

extension NSDate {
   
   convenience init?( year＃: Int, month＃: Int, day＃: Int,  hour＃: Int = 0,  minute＃: Int = 0,  second＃: Int = 0) {
      let dateComponents㊐ = NSDateComponents()
      dateComponents㊐.year = year＃
      dateComponents㊐.month = month＃
      dateComponents㊐.day = day＃
      dateComponents㊐.hour = hour＃
      dateComponents㊐.minute = minute＃
      dateComponents㊐.second = second＃
      let referenceDate㊐ = NSCalendar.currentCalendar().dateFromComponents(dateComponents㊐)
      if referenceDate㊐.isNilⓑ() { return nil }
      self.init(timeInterval: 0, sinceDate: referenceDate㊐!)
   }
   
   func addComponents㊐(years＃ years＃: Int = 0, monts＃: Int = 0, days＃: Int = 0, hours＃: Int = 0, minutes＃: Int = 0, seconds＃: Int = 0) -> NSDate {
      var computedDate㊐ = self
      computedDate㊐ += years＃.years＃㊐🅣
      computedDate㊐ += monts＃.months＃㊐🅣
      computedDate㊐ += days＃.days＃㊐🅣
      computedDate㊐ += hours＃.hours＃㊐🅣
      computedDate㊐ += minutes＃.minutes＃㊐🅣
      computedDate㊐ += seconds＃.seconds＃㊐🅣
      return computedDate㊐
   }
   
   var timeZoneOffset＃: Int { return Int(NSTimeInterval(NSTimeZone.localTimeZone().secondsFromGMTForDate(self)))/60/60 }
   
   var adjustedForLocalTimeZone㊐: NSDate {
      let timeZoneOffset = NSTimeInterval(NSTimeZone.localTimeZone().secondsFromGMTForDate(self))
      return dateByAddingTimeInterval(timeZoneOffset)
   }
   
   func formattedTo$(format$: String) -> String {
      let dateFormatterⓞ = NSDateFormatter(); dateFormatterⓞ.dateFormat = format$
      return dateFormatterⓞ.stringFromDate(self)
   }
   var fullDate$: String {
      let dateFormatterⓞ = NSDateFormatter()
      dateFormatterⓞ.dateFormat = "EEEE, MMMM d, YYYY"
      return dateFormatterⓞ.stringFromDate(self)
   }
   var trimmedFullDate$: String {
      let dateFormatterⓞ = NSDateFormatter()
      dateFormatterⓞ.dateFormat = "EEE, MMM d, YY"
      return dateFormatterⓞ.stringFromDate(self)
   }
   var trimmedFullDateNoYear$: String {
      let dateFormatterⓞ = NSDateFormatter()
      dateFormatterⓞ.dateFormat = "EEE, MMM d"
      return dateFormatterⓞ.stringFromDate(self)
   }
   var sixDigitDateMMddYY$: String {
      let dateFormatterⓞ = NSDateFormatter()
      dateFormatterⓞ.dateFormat = "MM/dd/YY"
      return dateFormatterⓞ.stringFromDate(self)
   }
   var fourDigitDate$: String {
      let dateFormatterⓞ = NSDateFormatter()
      dateFormatterⓞ.dateFormat = "MM/dd"
      return dateFormatterⓞ.stringFromDate(self)
   }
   var fourDigitDateWithWeekDay$: String {
      let dateFormatterⓞ = NSDateFormatter()
      dateFormatterⓞ.dateFormat = "EEE MM/dd"
      return dateFormatterⓞ.stringFromDate(self)
   }
   var month$: String {
      let dateFormatterⓞ = NSDateFormatter()
      dateFormatterⓞ.dateFormat = "MMMM"
      return dateFormatterⓞ.stringFromDate(self)
   }
   var time24h$: String {
      let timeFormatterⓞ = NSDateFormatter()
      timeFormatterⓞ.dateFormat = "hh:mm"
      return timeFormatterⓞ.stringFromDate(self)
   }
   var time12h$: String {
      let timeFormatterⓞ = NSDateFormatter()
      timeFormatterⓞ.dateFormat = "HH:mma"
      return timeFormatterⓞ.stringFromDate(self)
   }
   var compactDateTime$: String {
      let timeFormatterⓞ = NSDateFormatter()
      timeFormatterⓞ.dateFormat = "EEEE, MMMM dd @HH:mma"
      return timeFormatterⓞ.stringFromDate(self)
   }
   
   var dayOfTheWeek🅔: HKDate＋.DaysOfTheWeek🅔 {
      let dateFormatterⓞ = NSDateFormatter(); dateFormatterⓞ.dateFormat = "EEEE"
      var dayOfTheWeek🅔 = HKDate＋.DaysOfTheWeek🅔.Monday
      switch dateFormatterⓞ.stringFromDate(self) {
         case "Monday", "月曜日": dayOfTheWeek🅔 = .Monday
         case "Tuesday", "火曜日": dayOfTheWeek🅔 = .Tuesday
         case "Wednesday", "水曜日": dayOfTheWeek🅔 = .Wednesday
         case "Thursday", "木曜日": dayOfTheWeek🅔 = .Thursday
         case "Friday", "金曜日": dayOfTheWeek🅔 = .Friday
         case "Saturday", "土曜日": dayOfTheWeek🅔 = .Saturday
         case "Sunday", "日曜日": dayOfTheWeek🅔 = .Sunday
         default: break
      }
      return dayOfTheWeek🅔
   }
   var dayOfTheWeekLong$: String {
      let dateFormatterⓞ = NSDateFormatter(); dateFormatterⓞ.dateFormat = "EEEE"
      return dateFormatterⓞ.stringFromDate(self)
   }
   var dayOfTheWeekShort$: String {
      let dateFormatterⓞ = NSDateFormatter(); dateFormatterⓞ.dateFormat = "EEE"
      return dateFormatterⓞ.stringFromDate(self).left$(3).uppercaseString
   }
   
   var year＃: Int { return NSCalendar.currentCalendar().components(.Year, fromDate: self).year }
   var yearWith2Digits$: String { return String(NSCalendar.currentCalendar().components(.Year, fromDate: self).year).right$(2) }
   var month＃: Int { return NSCalendar.currentCalendar().components(.Month, fromDate: self).month }
   var day＃: Int { return NSCalendar.currentCalendar().components(.Day, fromDate: self).day }
   var hour＃: Int { return NSCalendar.currentCalendar().components(.Hour, fromDate: self).hour }
   var minute＃: Int { return NSCalendar.currentCalendar().components(.Minute, fromDate: self).minute }
   var second＃: Int { return NSCalendar.currentCalendar().components(.Second, fromDate: self).second }

   var lastDayOfTheMonth＃: Int {
      let calendar = NSCalendar.currentCalendar()
      let components = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: self)
      components.month += 1
      components.day = 0
      return calendar.dateFromComponents(components)!.month＃
   }
   
   /* TO INVESTIGATE: dateByAddingComponents()
   
   let components: NSDateComponents = NSDateComponents()
   components.setValue(1, forComponent: NSCalendarUnit.Month);
   let date: NSDate = NSDate()
   let expirationDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue: 0))
   
   */
   
   func yearsFrom＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Year, fromDate: date㊐, toDate: self, options: []).year }
   func monthsFrom＃(date㊐ :NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Month, fromDate: date㊐, toDate: self, options: []).month }
   func weeksFrom＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: date㊐, toDate: self, options: []).weekOfYear }
   func daysFrom＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Day, fromDate: date㊐, toDate: self, options: []).day }
   func hoursFrom＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Hour, fromDate: date㊐, toDate: self, options: []).hour }
   func minutesFrom＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Minute, fromDate: date㊐, toDate: self, options: []).minute }
   func secondsFrom＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Second, fromDate: date㊐, toDate: self, options: []).second }
   
   func yearsTo＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Year, fromDate: self, toDate: date㊐, options: []).year }
   func monthsTo＃(date㊐ :NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Month, fromDate: self, toDate: date㊐, options: []).month }
   func weeksTo＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: self, toDate: date㊐, options: []).weekOfYear }
   func daysTo＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Day, fromDate: self, toDate: date㊐, options: []).day }
   func hoursTo＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Hour, fromDate: self, toDate: date㊐, options: []).hour }
   func minutesTo＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Minute, fromDate: self, toDate: date㊐, options: []).minute }
   func secondsTo＃(date㊐: NSDate) -> Int{ return NSCalendar.currentCalendar().components(.Second, fromDate: self, toDate: date㊐, options: []).second }
   
   
} // NSDate

extension UIButton {
   func setSate(state: ButtonStateTypes🅔) {
      switch state {
         case .Enabled: enabled = true
         case .Disabled: enabled = false
         default: break
      }
   }
}

extension UILabel {
   func setSate(state: ButtonStateTypes🅔, color: UIColor) {
      switch state {
         case .Enabled: userInteractionEnabled = true
         case .Disabled: userInteractionEnabled = false
         default: break
      }
   }
}


// MARK: PHOTOS FRAMEWORK  ——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class HKPhotos＋ { // * a fetch result is an array of AnyObject *
   
   static let CameraRollLocalizedTitles$🅐 = ["Camera Roll", "カメラロール"] // to be eliminated in the future?
   static let VideoAlbumLocalizedTitles$🅐 = ["Videos", "ビデオ"]
   
   typealias PhotoAlbumList🅐Itemⓞ🅐$🅣 = (title$: String, albumⓐ🅒: PHAssetCollection, thumbNailⓐ: PHAsset)
   typealias PhotoAlbumListⓞ🅐$🅣🅐 = [PhotoAlbumList🅐Itemⓞ🅐$🅣]
   class func Album🅐SortCriterionⓑ(album1🅐$🅣: PhotoAlbumList🅐Itemⓞ🅐$🅣, album2ⓞ🅐$🅣: PhotoAlbumList🅐Itemⓞ🅐$🅣) -> Bool {
      if HKPhotos＋.CameraRollLocalizedTitles$🅐.contains(album1🅐$🅣.title$) { return true } else if HKPhotos＋.CameraRollLocalizedTitles$🅐.contains(album2ⓞ🅐$🅣.title$) { return false } else { return album1🅐$🅣.title$ < album2ⓞ🅐$🅣.title$ }
   }
   typealias PhotoAlbumList🅓Itemⓞ🅐$🅣 = (albumⓐ🅒: PHAssetCollection, thumbNailⓐ: PHAsset)
   typealias PhotoAlbumListⓞ🅐🅣$🅓 = [String : PhotoAlbumList🅓Itemⓞ🅐$🅣]
   
   class PhotoAlbumⓞ {
      var albumⓐ🅒 = PHAssetCollection() // pointers: unfetched assets
      var imagesⓐ🅐 = [PHAsset]()  // fetches images
      init(albumⓐ🅒: PHAssetCollection = PHAssetCollection(), imagesⓐ🅐:[PHAsset] = [PHAsset]()) { self.albumⓐ🅒 = albumⓐ🅒; self.imagesⓐ🅐 = imagesⓐ🅐 }
      func fetchPicturesⓐ🅐() {
         imagesⓐ🅐.removeAll()
         let fetchOptionsⓞ = PHFetchOptions()
         fetchOptionsⓞ.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: NO)]
         let pictures﹖🅐  = PHAsset.fetchAssetsInAssetCollection(albumⓐ🅒, options: fetchOptionsⓞ)
         if pictures﹖🅐.isNotEmptyⓑ { pictures﹖🅐.enumerateObjectsUsingBlock({ (image﹖, index, pointer) -> Void in self.imagesⓐ🅐.append(image﹖ as! PHAsset) }) }
      }
   }
   
   class func FetchAlbumListⓞ🅐(thumbnailSizeⓖ² thumbnailSizeⓖ²: CGSize? = nil) -> PhotoAlbumListⓞ🅐$🅣🅐 { // if thumbnailSizeⓖ² is ommited the thumbnails are not fetched
      var albumList🅐 = PhotoAlbumListⓞ🅐$🅣🅐()
      for albumType🅔 in [PHAssetCollectionType.SmartAlbum, .Album/*, .Moment*/] {
         let albums🅐: PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(albumType🅔, subtype: .Any, options: nil) // get list of albums
         albums🅐.enumerateObjectsUsingBlock { (album﹖, index＃, pointerⓟ⃗) -> Void in // iterate in each album
            let albumⓐ🅒 = album﹖ as! PHAssetCollection
            let fetchOptionsⓞ = PHFetchOptions()
            fetchOptionsⓞ.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: NO)]
            fetchOptionsⓞ.predicate = NSPredicate(format: "mediaType = \(PHAssetMediaType.Image.rawValue)")
            let pictures﹖🅐  = PHAsset.fetchAssetsInAssetCollection(albumⓐ🅒, options: fetchOptionsⓞ) // get list of pictures in album (not the images inside the 'assets')
            if !VideoAlbumLocalizedTitles$🅐.contains(albumⓐ🅒.localizedTitle!) && pictures﹖🅐.isNotEmptyⓑ { // empty albums are not listed
               var item🅣: (title$: String, albumⓐ🅒: PHAssetCollection, thumbNailⓐ: PHAsset)
               item🅣.title$ = albumⓐ🅒.localizedTitle!
               item🅣.albumⓐ🅒 = albumⓐ🅒
               item🅣.thumbNailⓐ = pictures﹖🅐.firstObject as! PHAsset
               albumList🅐.append(item🅣)
            }
         }
      }
      albumList🅐.sortInPlace(Album🅐SortCriterionⓑ)
      return albumList🅐
   }
   
   class func FetchAlbumListⓞ🅓(thumbnailSizeⓖ² thumbnailSizeⓖ²: CGSize? = nil) -> PhotoAlbumListⓞ🅐🅣$🅓 { // if converSize is ommited the thumbnails are not fetched
      var albumList🅓 = PhotoAlbumListⓞ🅐🅣$🅓()
      for albumType🅔 in [PHAssetCollectionType.SmartAlbum, .Album/*, .Moment*/] {
         let albums🅐: PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(albumType🅔, subtype: .Any, options: nil)
         albums🅐.enumerateObjectsUsingBlock { (album﹖, index＃, pointerⓟ⃗) -> Void in
            let albumⓐ🅒 = album﹖ as! PHAssetCollection
            let fetchOptionsⓞ = PHFetchOptions()
            fetchOptionsⓞ.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: NO)]
            let pictures﹖🅐  = PHAsset.fetchAssetsInAssetCollection(albumⓐ🅒, options: fetchOptionsⓞ)
            if !VideoAlbumLocalizedTitles$🅐.contains(albumⓐ🅒.localizedTitle!) && pictures﹖🅐.isNotEmptyⓑ { albumList🅓[albumⓐ🅒.localizedTitle!] = (albumⓐ🅒, pictures﹖🅐.firstObject as! PHAsset) }
         }
      }
      return albumList🅓
   }
   
   class func RegisterPhotoLibaryObserver(observerⓞ observerⓞ: PHPhotoLibraryChangeObserver) { PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(observerⓞ) }
   class func UnregisterPhotoLibraryObserver(observerⓞ observerⓞ: PHPhotoLibraryChangeObserver) { PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(observerⓞ) }
   
}



extension UIImage {
   
   func scaleToSize(widthⓖ: CGFloat, heightⓖ: CGFloat) -> UIImage {
      UIGraphicsBeginImageContext(CGSizeMake(widthⓖ, heightⓖ))
      drawInRect(CGRectMake(0,0, widthⓖ, heightⓖ))
      let outputⓞ = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return outputⓞ
   }
   
   func scaleToFactor(factorⓖ: CGFloat) -> UIImage {
      let widthⓖ = size.width * factorⓖ
      let heightⓖ = size.height * factorⓖ
      UIGraphicsBeginImageContext(CGSizeMake(widthⓖ, heightⓖ))
      drawInRect(CGRectMake(0,0, widthⓖ, heightⓖ))
      let outputⓞ = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return outputⓞ
   }
   
// the UIImage does not need to come from a particular format in order to be exported to such via NSData. Apparently when UIImage is loaded it's a raw format
   func toJPGData(compressionQualityⓖ: CGFloat = 0.7) -> NSData? { return UIImageJPEGRepresentation(self, compressionQualityⓖ) }
   func toPNGData() -> NSData? { return UIImagePNGRepresentation(self) }
   
}

extension NSData {
   
   var imageType$: String? {
      var bytes＃8🅐 = [UInt8]()
      getBytes(&bytes＃8🅐, length: 1)
      let output$ : String?
      switch (bytes＃8🅐[0]) {
         case 0xFF: output$ = "jpg"
         case 0x89: output$ = "png"
         case 0x47: output$ = "gif"
         case 0x49, 0x4D : output$ = "tiff"
         default: output$ = nil // unknown
      }
      return output$
   }
   
}

// MARK: CORE DATA ————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class HKData＋ {
   
   static let persistentStorageⓞ = NSUserDefaults.standardUserDefaults()
   
   class func writePersistent﹖(key$ key$: String, object﹖: AnyObject) { persistentStorageⓞ.setObject(object﹖, forKey: key$) }
   class func writePersistentⓑ(key$ key$: String, booleanⓑ: Bool) { persistentStorageⓞ.setBool(booleanⓑ, forKey: key$) }
   class func writePersistent＃i(key$ key$: String, number＃: Int) { persistentStorageⓞ.setInteger(number＃, forKey: key$) }
   class func writePersistent＃f(key$ key$: String, number＃: Float) { persistentStorageⓞ.setFloat(number＃, forKey: key$) }
   class func writePersistent＃d(key$ key$: String, number＃: Double) { persistentStorageⓞ.setDouble(number＃, forKey: key$) }
   class func writePersistent🅤(key$ key$: String, URL🅤: NSURL) { persistentStorageⓞ.setURL(URL🅤, forKey: key$) }

   class func readPersistent﹖(key$ key$: String) -> AnyObject? { return persistentStorageⓞ.objectForKey(key$) } // will need casting
   class func readPersistentⓑ(key$ key$: String) -> Bool? { return persistentStorageⓞ.boolForKey(key$) }
   class func readPersistent﹖🅐(key$ key$: String) -> [AnyObject]? { return persistentStorageⓞ.arrayForKey(key$) as [AnyObject]?}
   class func readPersistent🅐(key$ key$: String) -> Dictionary<String,AnyObject>? { return persistentStorageⓞ.dictionaryForKey(key$) as Dictionary<String,AnyObject>? }
   class func readPersistent$(key$ key$: String) -> String? { return persistentStorageⓞ.stringForKey(key$) }
   class func readPersistent$🅐(key$ key$: String) -> [String]? { return persistentStorageⓞ.stringArrayForKey(key$) }
   class func readPersistent＃i(key$ key$: String) -> Int? { return persistentStorageⓞ.integerForKey(key$) }
   class func readPersistent＃f(key$ key$: String) -> Float? { return persistentStorageⓞ.floatForKey(key$) }
   class func readPersistent＃d(key$ key$: String) -> Double? { return persistentStorageⓞ.doubleForKey(key$) }
   class func readPersistentß(key$ key$: String) -> NSData? { return persistentStorageⓞ.dataForKey(key$) }
   class func readPersistent🅤(key$ key$: String) -> NSURL? { return persistentStorageⓞ.URLForKey(key$) }
   
   class func deletePersistent(key$ Key$: String) { persistentStorageⓞ.removeObjectForKey(Key$) }
   
   enum CoreDataTypes🅔 {
      case Booleanⓑ
      case Integer＃
      case Float＃
      case Double＃
      case String$
      case Binaryß
   }
   
   class func createPredicateⓞ(fieldName$: String, operator$: String, fieldValue$: String) -> NSPredicate { // need to implement possible AND/OR on predicate by input ﹙$$$﹚🅣🅐
      return NSPredicate(format: fieldName$ + " " + operator$ + " %@", fieldValue$)
   }
   
}


extension NSManagedObjectContext {
   
   func commitChangesⓑ() -> Bool {
      var outputⓑ = true
      do { try  save() } catch { outputⓑ = false; print("\n* * * Error saving object! * * *\n") }
      return outputⓑ
   }
   
   func createObjectInEntityⓞ(entity$: String, assignmentsƒ: (managedObjectⓞ: NSManagedObject) -> (), completionƒ: (() -> ())? = nil) -> NSManagedObject {
      let MOⓞ = NSEntityDescription.insertNewObjectForEntityForName(entity$, inManagedObjectContext: self)
      assignmentsƒ(managedObjectⓞ: MOⓞ)
      commitChangesⓑ()
      completionƒ?()
      return MOⓞ
   }
   
   func deleteObjectⓑ(objectMOⓞ: NSManagedObject) -> Bool {
      var outputⓑ = true
      deleteObject(objectMOⓞ)
      do { try save() } catch { outputⓑ = false; print("Error deleting object!") }
      return outputⓑ
   }
   
   func fetchEntityObjects(entityName$: String, predicateⓞ: NSPredicate? = nil) -> [NSManagedObject]? {
      var fetchResultAO🅐: [AnyObject]?
      var entityMO🅐 = [NSManagedObject]()
      let fetchRequestⓞ = NSFetchRequest(entityName: entityName$); fetchRequestⓞ.returnsObjectsAsFaults = false
      if predicateⓞ.isNotNilⓑ() { fetchRequestⓞ.predicate = predicateⓞ }
      do { fetchResultAO🅐 = try executeFetchRequest(fetchRequestⓞ)
         if fetchResultAO🅐?.count > 0 { for recordMO🅐 in fetchResultAO🅐! as! [NSManagedObject] { entityMO🅐.append(recordMO🅐) } } // for edit: recordMO🅐.setValue(<WhatEver>, forKey: fieldName$)
      } catch { print("Fetch Error: データベスと接続が失敗しまった！") }
      return entityMO🅐.count > 0 ? entityMO🅐 : nil
      // if fields are altered once there are records already, we get a nasty error: "The model used to open the stroe is incompatible with the one used to create the store"
      // we must delete the app from the terminal to delete data model, then perform a project clean (⬆︎⌘K), then restart
      // PREDICATE EXAMPLE: let predicateⓞ = NSPredicate(format: "eventType = %@ AND eventID = %@", eventListItemⓞ.eventType＃!, eventListItemⓞ.eventID$!) // string has ''
   }
   
}

extension NSManagedObject {
   
   func valueForAttributeⓑ(attributeName$: String) -> Bool?  { return valueForKey(attributeName$) as? Bool } // valueForKey returns an NSManagedObject so it must be cast into the desired type
   func valueForAttribute$(attributeName$: String) -> String?  { return valueForKey(attributeName$) as? String }
   func valueForAttribute＃i(attributeName$: String) -> Int?  { return valueForKey(attributeName$) as? Int }
   func valueForAttribute＃f(attributeName$: String) -> Float?  { return valueForKey(attributeName$) as? Float }
   func valueForAttribute＃d(attributeName$: String) -> Double?  { return valueForKey(attributeName$) as? Double }
   func valueForAttributeß(attributeName$: String) -> UIImage?  { if let imageß = valueForKey(attributeName$) as? NSData { return UIImage(data: imageß) } else { return nil } }
   func valueForAttribute㊐(attributeName$: String) -> NSDate?  { return valueForKey(attributeName$) as? NSDate }
}


// MARK: MAPS —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class Locationⓞ: CustomDebugStringConvertible {
   var name$: String?
   var coordinate＃²: CLLocationCoordinate2D
   var streetAndNumber$: String?
   var city$: String?
   var zipCode$: String?
   var state$: String?
   var country$: String?
   
   init(coordinate＃²: CLLocationCoordinate2D = CLLocationCoordinate2D(), name$: String? = nil, address$: String? = nil, city$: String? = nil, zipCode$: String? = nil, state$: String? = nil, country$: String? = nil) {
      self.name$ = name$
      self.coordinate＃² = coordinate＃²
      self.streetAndNumber$ = address$
      self.city$ = city$
      self.zipCode$ = zipCode$
      self.state$ = state$
      self.country$ = country$
   }
   
   func fetchAddress(completionƒ completionƒ: (()->())? ) { HKMaps＋.FetchLocationAddress(locationⓞ: self, completionƒ: completionƒ) }
   
   var addressForPrint$🅣: (line1$: String, line2$: String) {
      var output$: (line1$: String, line2$: String)
         output$.line1$ = streetAndNumber$.isNilⓑ() ? "" : streetAndNumber$!
         output$.line2$ = city$.isNilⓑ() ? "" : city$!
         if state$.isNotNilⓑ() && zipCode$.isNotNilⓑ() { output$.line2$ += ", " }
         output$.line2$ += state$.isNilⓑ() ? "" : state$!
         output$.line2$ += zipCode$.isNilⓑ() ? "" : " \(zipCode$!)"
      return output$
   }
   var hasAddressⓑ: Bool { return (addressForPrint$🅣.line1$ == "" && addressForPrint$🅣.line2$ == "") }
   
   var debugDescription: String { return "Country = \(country$)\nState = \(state$)\nCity = \(city$)\nZipCode = \(zipCode$)\nAddress = \(streetAndNumber$)" }
}

class HKMaps＋ {
 /*
    In order for the LocationManger to be able to request user's permission for tracking, the following keys must be added to the info.plist at Project's properties -> Custom iOS Target Properties -> info:
    NSLocationWhenInUseUsageDescription: String  |&  NSLocationAlwaysUsageDescription: String
   
   the viewController that will be the CLLocationManagerDelegate must implement the function locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]),
      that will be called by the locationManager when it updates info
   in order to draw a polyline the two last locations must be read
 */
   
   enum trackingAccuracies🅔 {
      case Navigation
      case Best
      case m10
      case m100
      case Km1
      case Km3
   }
   
   enum authorizationTypes🅔 {
      case Active
      case Permanent
   }
   
   enum authorizationStatusTypes🅔 {
      case Always
      case Foreground
      case UnDetermined
      case Restricted
      case Denied
   }
   
   static let LocationManagerⓞ = CLLocationManager()
   static var CurrentLocationⓞ = CLLocation()
   
   static var LocationTrackingEnabledⓑ＋: Bool { get { return CLLocationManager.locationServicesEnabled() } }
   
   class func AuthorizationStatus🅔() -> authorizationStatusTypes🅔 {
      switch CLLocationManager.authorizationStatus() {
         case .NotDetermined: return .UnDetermined
         case .Restricted: return .Restricted
         case .Denied: return .Denied
         case .AuthorizedAlways: return .Always
         case .AuthorizedWhenInUse: return .Foreground
      }
   }
   
   class func ActivateLocationTracking(delegateⓞ delegateⓞ: CLLocationManagerDelegate, accuracy🅔: trackingAccuracies🅔 = .Best, authorizationType🅔: authorizationTypes🅔 = .Active) {
      LocationManagerⓞ.delegate = delegateⓞ
      switch accuracy🅔 {
         case .Navigation: LocationManagerⓞ.desiredAccuracy = kCLLocationAccuracyBestForNavigation
         case .Best: LocationManagerⓞ.desiredAccuracy = kCLLocationAccuracyBest
         case .m10: LocationManagerⓞ.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
         case .m100: LocationManagerⓞ.desiredAccuracy = kCLLocationAccuracyHundredMeters
         case .Km1: LocationManagerⓞ.desiredAccuracy = kCLLocationAccuracyKilometer
         case .Km3: LocationManagerⓞ.desiredAccuracy = kCLLocationAccuracyThreeKilometers
      }
      if authorizationType🅔 == .Permanent { LocationManagerⓞ.requestAlwaysAuthorization() } else { LocationManagerⓞ.requestWhenInUseAuthorization() }
      LocationManagerⓞ.startUpdatingLocation()
      /*
         authorization requests only prompt user when authorization status is kCLAuthorizationStatusNotDetermined
         to react to authorzation changes the CLLocation manager delegate must implement: locationManagerdidChangeAuthorizationStatus()
      */
   }
   
   class func DeactivateLocationTracking() { LocationManagerⓞ.stopUpdatingLocation() }
   
   class func FetchLocationAddress(locationⓞ locationⓞ: Locationⓞ, completionƒ: (() -> ())? = nil) {
      CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: locationⓞ.coordinate＃².latitude, longitude: locationⓞ.coordinate＃².longitude), completionHandler: { (placemarksⓞ, error) in
         if error.isNilⓑ() {
            locationⓞ.country$ = placemarksⓞ![0].country
            locationⓞ.state$ = placemarksⓞ![0].administrativeArea
            locationⓞ.zipCode$ = placemarksⓞ![0].postalCode
            locationⓞ.city$ = placemarksⓞ![0].locality
            let streetName$ = placemarksⓞ![0].thoroughfare
            let streetNumber$ = placemarksⓞ![0].subThoroughfare.isNilⓑ() ? "" : placemarksⓞ![0].subThoroughfare! + " "
            locationⓞ.streetAndNumber$ = streetNumber$ + (streetName$ ?? "")
            completionƒ?()
         } else { print("Error fetching location info: \(error!.code): \(error!.description)") }
      })
   }
   
   class func generatePrintAddress$(streetAndNumber$ streetAndNumber$: String? = nil, city$: String? = nil, state$: String? = nil, zipCode$: String? = nil) -> String {
      var output$ = streetAndNumber$ ?? ""
      output$ += output$.isEmpty ? "" : ", " + (city$ ?? "")
      output$ += output$.isEmpty ? "" : ", " + (state$ ?? "") + (zipCode$ ?? "")
      return output$
   }
   
}

extension CLLocationManagerDelegate {
   func startTrackingLocation(accuracy🅔 accuracy🅔: HKMaps＋.trackingAccuracies🅔 = .Best, authorizationType🅔: HKMaps＋.authorizationTypes🅔 = .Active) { HKMaps＋.ActivateLocationTracking(delegateⓞ: self, accuracy🅔: accuracy🅔, authorizationType🅔: authorizationType🅔) }
   func stopTrackingLocation() { HKMaps＋.DeactivateLocationTracking() }
}



// MARK: HARDWARE —————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

class HKDevice＋ {

   static let DeviceTypes$🅐 = [
      "iPod5,1": "iPod Touch 5",
      "iPhone3,1":  "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
      "iPhone4,1": "iPhone 4S",
      "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
      "iPhone5,3": "iPhone 5C", "iPhone5,4": "iPhone 5C",
      "iPhone6,1": "iPhone 5S", "iPhone6,2": "iPhone 5S",
      "iPhone7,2": "iPhone 6",
      "iPhone7,1": "iPhone 6 Plus",
      "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
      "iPad3,1": "iPad 3", "iPad3,2": "iPad 3", "iPad3,3": "iPad 3",
      "iPad3,4": "iPad 4", "iPad3,5": "iPad 4", "iPad3,6": "iPad 4",
      "iPad4,1": "iPad Air", "iPad4,2": "iPad Air", "iPad4,3": "iPad Air",
      "iPad5,1": "iPad Air 2", "iPad5,3": "iPad Air 2", "iPad5,4": "iPad Air 2",
      "iPad2,5": "iPad Mini", "iPad2,6": "iPad Mini", "iPad2,7": "iPad Mini",
      "iPad4,4": "iPad Mini", "iPad4,5": "iPad Mini", "iPad4,6": "iPad Mini",
      "iPad4,7": "iPad Mini", "iPad4,8": "iPad Mini", "iPad4,9": "iPad Mini",
      "x86_64": "Simulator", "i386": "Simulator"
   ]
}

extension UIDevice { // doesn't work on Swift 2.2
   var modelName$: String {
      var systemInfo = utsname()
      uname(&systemInfo)
      let machine = systemInfo.machine
      let mirror = Mirror(reflecting: machine)
      var identifier = ""
      for child in mirror.children where child.value as? Int != 0 { identifier.append(UnicodeScalar(UInt8(child.value as! Int))) }
      return HKDevice＋.DeviceTypes$🅐[identifier] ?? identifier
   }
}


/*
NSUUID *myDevice = [NSUUID UUID];
NSString *deviceUDID = myDevice.UUIDString;
NSString *deviceName = myDevice.Name;
NSString *deviceSystemName = myDevice.systemName;
NSString *deviceOSVersion = myDevice.systemVersion;
NSString *deviceModel = myDevice.model;
*/




// MARK: OLD EXPERIMENTS


//   func objectWithContextID(contextID$: String) -> UIView? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews {                        // ... but POLYMORPHISM would have fixed the issue in a safer and more orthodox manner. But WE MUST KNOW WHAT KIND of object will be RETURNED
//         if subView is HikarianUIView { let idObject: HikarianUIView = subView as! HikarianUIView; if idObject.contextID$ == contextID$ { return idObject } }
//         if subView is HikarianUILabel { let idObject: HikarianUILabel = subView as! HikarianUILabel; if idObject.contextID$ == contextID$ { return idObject } }
//         if subView is HikarianUIImage { let idObject: HikarianUIImage = subView as! HikarianUIImage; if idObject.contextID$ == contextID$ { return idObject } }
//         if subView is HikarianUIButton { let idObject: HikarianUIButton = subView as! HikarianUIButton; if idObject.contextID$ == contextID$ { return idObject } }
//      }
//      return nil
//   }
//   func objectsWithContextIDs🅐(contextIDs$: [String]) -> [UIView]? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      var objects🅐 = [UIView]()
//      for (_, contextID$) in contextIDs$.enumerate() {
//         for subView in subviews {
//            if subView is HikarianUIView { let hikarianSubView = subView as! HikarianUIView; if hikarianSubView.contextID$ == contextID$ { objects🅐.append(hikarianSubView) } }
//            if subView is HikarianUILabel { let hikarianSubView = subView as! HikarianUILabel; if hikarianSubView.contextID$ == contextID$ { objects🅐.append(hikarianSubView) } }
//            if subView is HikarianUIImage { let hikarianSubView = subView as! HikarianUIImage; if hikarianSubView.contextID$ == contextID$ { objects🅐.append(hikarianSubView) } }
//            if subView is HikarianUIButton { let hikarianSubView = subView as! HikarianUIButton; if hikarianSubView.contextID$ == contextID$ { objects🅐.append(hikarianSubView) } }
//         }
//      }
//      return objects🅐.count == 0 ? nil : objects🅐
//   }
//   func _objectWithContextID(contextID: String) -> NSObject? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews {                        // ... but POLYMORPHISM would have fixed the issue in a safer and more orthodox manner. But WE MUST KNOW WHAT KIND of object will be RETURNED
//         if subView is HikarianUIView { let idObject: HikarianUIView = subView as! HikarianUIView; if idObject.contextID == contextID { return idObject } }
//         //         if subView is HikarianUIImageView { let idObject: HikarianUIImageView = subView as! HikarianUIImageView; if idObject.contextID == contextID { return idObject } }
//         if subView is HikarianUIImage { let idObject: HikarianUIImage = subView as! HikarianUIImage; if idObject.contextID == contextID { return idObject } }
//         if subView is HikarianUIButton { let idObject: HikarianUIButton = subView as! HikarianUIButton; if idObject.contextID == contextID { return idObject } }
//      }
//      return nil
//   }

// DO THIESE MAKE ANY SENSE??
//   internal func viewWithContextID(contextID$: String) -> HikarianUIView? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews { let idObject: HikarianUIView = subView as! HikarianUIView; if idObject.contextID$ == contextID$ { return idObject } }
//      return nil
//   }
//   internal func tableViewWithContextID(contextID$: String) -> HikarianUITableView? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews { let idObject: HikarianUITableView = subView as! HikarianUITableView; if idObject.contextID$ == contextID$ { return idObject } }
//      return nil
//   }
//   internal func imageViewWithContextID(contextID: String) -> HikarianUIImageView? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews { let idObject: HikarianUIImageView = subView as! HikarianUIImageView; if idObject.contextID == contextID { return idObject } }
//      return nil
//   }
//   internal func imageWithContextID(contextID$: String) -> HikarianUIImage? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews { let idObject: HikarianUIImage = subView as! HikarianUIImage; if idObject.contextID$ == contextID$ { return idObject } }
//      return nil
//   }
//   internal func buttonWithContextID(contextID$: String) -> HikarianUIButton? { // since all objects will be subClasses of UIView, this trick works, and the properties of the returned object can be managed. In case of AnyObject you can't do SHIT.
//      for subView in subviews { let idObject: HikarianUIButton = subView as! HikarianUIButton; if idObject.contextID$ == contextID$ { return idObject } }
//      return nil
//   }

//   func objectWithContextID(contextID: String) -> (objectⓞ: AnyObject, objectClassName: String) {
//      for subView in subviews {
//         let objectClassAsString = subView.dynamicType.description()
//         let objectClass =
//         let idObject: HikarianUIView = subView as! HikarianUIView
//         if subView.contextID
//      }
//   }


//   func slideForKeyboardAndReturnOffset(notification notification: NSNotification, duration: NSTimeInterval = 0.4) -> CGFloat { // if the firstResponder is a UITextField of a UITextView, it slides the view up by the height of the keyboard and returns it
//      var keyboardHeight = CGFloat()
//      if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//         keyboardHeight = keyboardSize.height
//         if let responder = firstResponder as? UIView {
//            if (responder.className == "UITextField") || (responder.className == "UITextView") || (responder.className == "HikarianUITextView") || (responder.className == "HikarianUITextView") {
//               if responder.absoluteOrigin.y + responder.frame.height >= (responder.window!.frame.height - keyboardHeight) {
//                  UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { self.frame =  CGRect(x: self.frame.origin.x, y: self.frame.origin.y - keyboardHeight, width: self.frame.width, height: self.frame.height) }, completion: nil)
//               }
//            }
//         }
//      }
//      return keyboardHeight
//   }
