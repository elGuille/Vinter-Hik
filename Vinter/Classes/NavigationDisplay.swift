//
//  NavigationTree.swift
//  Vinter
//
//  Created by Hikarus on 16/8/24.
//  Copyright © 2016 Hikarian. All rights reserved.
//

import Foundation
import UIKit

class NavigationDisplay {
   var maxDepth＃: Int! = nil
   var currentDepth＃: Int = 0
   var rootLabelⓞ: UILabel!
   var labelsⓞ🅐 = [UILabel?]()
   let spaceBetweenLabelsFactorⓖ: CGFloat = 1.2
   var spaceBetweenLabelsⓖ: CGFloat = 0
   var displayViewⓞ: UIView!
   var delegateⓞ: UIGestureRecognizerDelegate!
   var tapHandlerƒ: Selector!
   
   init(displayViewⓞ: UIView, maxDepth＃: Int, rootLabelⓞ: UILabel, delegateⓞ: UIGestureRecognizerDelegate, tapHandlerƒ: Selector) {
      self.displayViewⓞ = displayViewⓞ
      self.maxDepth＃ = maxDepth＃
      self.rootLabelⓞ = rootLabelⓞ
      spaceBetweenLabelsⓖ = rootLabelⓞ.frame.width * spaceBetweenLabelsFactorⓖ
      self.delegateⓞ = delegateⓞ
      self.tapHandlerƒ = tapHandlerƒ
   }
   
   func natigateTo(level＃: Int) {
      if level＃ == currentDepth＃ { return }
      if level＃ > currentDepth＃ { sink(level＃ - currentDepth＃) }
      if level＃ < currentDepth＃ { rise(currentDepth＃ - level＃) }
   }
   
   func sink(levels＃: Int = 1) {
      for _ in 1...levels＃ {
         if currentDepth＃ == maxDepth＃ { return } // instead of throwing an error, it will just go as far down as maxDepth＃ allows
         currentDepth＃ += 1
         if labelsⓞ🅐.maxIndex＃ >= currentDepth＃ { labelsⓞ🅐[currentDepth＃.countToIndex＃]!.visibleⓑ = YES ; return }
         let newLabelⓞ = spawnLabelⓞ(depthLevel＃: currentDepth＃, text$: String(currentDepth＃))
         labelsⓞ🅐.append(newLabelⓞ)
         displayViewⓞ.addSubview(newLabelⓞ)
      }
   }
   
   func rise(levels＃: Int = 1) {
      for _ in 1...levels＃ {
         if currentDepth＃ == 0 { return }
         labelsⓞ🅐[currentDepth＃.countToIndex＃]!.visibleⓑ = NO
         currentDepth＃ -= 1
      }
   }
   
   func setLabelsVisibility() {
      for (depthLevel＃, labelⓞ) in labelsⓞ🅐.enumerate() {
         guard let labelⓞ = labelⓞ else { return }
         if depthLevel＃ <= maxDepth＃  { labelⓞ.visibleⓑ = YES } else { labelⓞ.visibleⓑ = NO }
      }
   }
   
   func spawnLabelⓞ(depthLevel＃ depthLevel＃: Int, text$: String) -> UILabel {
      let newLabelⓞ = UILabel(frame: rootLabelⓞ.frame)
      newLabelⓞ.text = text$
      newLabelⓞ.font = rootLabelⓞ.font
      newLabelⓞ.textColor = rootLabelⓞ.textColor
      newLabelⓞ.shadowColor = rootLabelⓞ.shadowColor
      newLabelⓞ.shadowOffset = rootLabelⓞ.shadowOffset
      newLabelⓞ.userInteractionEnabled = YES
      newLabelⓞ.setFrame(xⓖ: rootLabelⓞ.frame.origin.x + (rootLabelⓞ.frame.width + spaceBetweenLabelsⓖ) * CGFloat(currentDepth＃) , ＋Xⓑ: NO)
      let tapGRⓞ = NavigationTapGestureRecognizer(target: delegateⓞ, action: tapHandlerƒ)
      tapGRⓞ.depthLevel＃ = depthLevel＃
      newLabelⓞ.addGestureRecognizer(tapGRⓞ)
      return newLabelⓞ
   }
   
   
}