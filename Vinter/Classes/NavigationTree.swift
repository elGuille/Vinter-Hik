//
//  NavigationTree.swift
//  Vinter
//
//  Created by Hikarus on 16/8/24.
//  Copyright © 2016 Hikarian. All rights reserved.
//

import Foundation
import UIKit

class TreeNavigationalDisplay {
   var maxDepth＃: Int! = nil
   var currentDepth＃: Int = 0
   var rootLabelⓞ: UILabel!
   var labelsⓞ🅐 = [UILabel?]()
   let spaceBetweenLabelsFactorⓖ: CGFloat = 1.2
   var spaceBetweenLabelsⓖ: CGFloat = 0
   var displayViewⓞ: UIView!
   
   init(displayViewⓞ: UIView, maxDepth＃: Int, rootLabelⓞ: UILabel) {
      self.displayViewⓞ = displayViewⓞ
      self.maxDepth＃ = maxDepth＃
      self.rootLabelⓞ = rootLabelⓞ
      spaceBetweenLabelsⓖ = rootLabelⓞ.frame.width * spaceBetweenLabelsFactorⓖ
   }
   
   func sink() {
      if currentDepth＃ == maxDepth＃ { return }
      currentDepth＃ += 1
      if labelsⓞ🅐.maxIndex＃ >= currentDepth＃ { return }
      let newLabelⓞ = spawnLabelⓞ()
      newLabelⓞ.text = String(currentDepth＃)
      newLabelⓞ.setFrame(xⓖ: (rootLabelⓞ.frame.width + spaceBetweenLabelsⓖ) * CGFloat(currentDepth＃) , ＋Xⓑ: true)
      labelsⓞ🅐.append(newLabelⓞ)
      displayViewⓞ.addSubview(newLabelⓞ)
   }
   
   func rise() {
      currentDepth＃ -= 1
   }
   
   func setLabelsVisibility() {
      for (depthLevel＃, labelⓞ) in labelsⓞ🅐.enumerate() {
         guard let labelⓞ = labelⓞ else { return }
         if depthLevel＃ <= maxDepth＃  { labelⓞ.visibleⓑ = true } else { labelⓞ.visibleⓑ = false }
      }
   }
   
   func spawnLabelⓞ() -> UILabel {
      let newLabelⓞ = UILabel(frame: rootLabelⓞ.frame)
      newLabelⓞ.font = rootLabelⓞ.font
      newLabelⓞ.textColor = rootLabelⓞ.textColor
      newLabelⓞ.shadowColor = rootLabelⓞ.shadowColor
      newLabelⓞ.shadowOffset = rootLabelⓞ.shadowOffset
      return newLabelⓞ
   }
   
   
}