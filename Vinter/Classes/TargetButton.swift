//
//  TargetButton.swift
//  Vinter
//
//  Created by Guillermo García on 04/08/16.
//  Copyright © 2016 Vinter. All rights reserved.
//

import UIKit

class TargetButtonIV: UIImageView {

   var level＃ = -1
   var index＃ = -1
   var coordinateⓖ² = CGPoint()
   var tapGRⓞ: TargetTapGestureRecognizer!
   var dragGRⓞ: TargetPanGestureRecognizer!
   
   convenience init(imageⓞ: UIImage, imagesⓞ🅐: [UIImage]? = nil, alphaⓖ: CGFloat, depthLevel＃: Int, index＃: Int, coordinateⓖ²: CGPoint, delegateⓞ: UIGestureRecognizerDelegate, tapHandlerƒ: Selector, dragHandlerƒ: Selector) {
      self.init()
      self.level＃ = depthLevel＃
      self.index＃ = index＃
      self.coordinateⓖ² = coordinateⓖ²
      image = imageⓞ
      animationImages = imagesⓞ🅐
      userInteractionEnabled = YES
      tapGRⓞ = TargetTapGestureRecognizer(target: delegateⓞ, action: tapHandlerƒ) ; tapGRⓞ.targetNumber＃ = index＃
      dragGRⓞ = TargetPanGestureRecognizer(target: delegateⓞ, action: dragHandlerƒ) ; dragGRⓞ.targetNumber＃ = index＃
      addGestureRecognizer(tapGRⓞ!)
      addGestureRecognizer(dragGRⓞ!)
      alpha = alphaⓖ
      if imagesⓞ🅐.isNotNilⓑ() { startAnimating() }
   }

   
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
