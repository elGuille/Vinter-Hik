//
//  TargetVC
//  Vinter
//
//  Created by Guillermo García on 03/08/16.
//  Copyright © 2016 Vinter. All rights reserved.
//

import UIKit
// From PlayerVC
import AVKit
import AVFoundation

class TargetVC: UIViewController, UIGestureRecognizerDelegate {
   
   @IBOutlet weak var Ψ﹫: UILabel!
   
   enum Status { case Playing, Paused, Stopped, Error }
   var playerⓞ: AVPlayer!
   var playerLayerⓞ = AVPlayerLayer()
   
   var status🅔: Status = .Stopped
   var videoⓞ: AVPlayerItem!
   var videoAtEndⓑ: Bool = false
   var draggedTargetIVⓞ: UIImageView?
   var currentPanPointⓖ² = CGPoint()
   var draggingTargetⓞ: TargetButtonIV?
   var navigationTreeⓞ: TreeNavigationalDisplay!
   
   
   override func viewDidLoad() { super.viewDidLoad()
      let tapGRⓞ = UITapGestureRecognizer(target: self, action: #selector(TargetVC.spawnTarget(_:)))
      tapGRⓞ.delegate = self //; singleTapGRⓞ.requireGestureRecognizerToFail(longPressGRⓞ)
      view.addGestureRecognizer(tapGRⓞ)
      navigationTreeⓞ = TreeNavigationalDisplay(displayViewⓞ: view, maxDepth＃: maxVinterDepth＃, rootLabelⓞ: Ψ﹫)
      initializeActiveTargets()
      initializeVideo()
   }
   
   func initializeVideo() {
      let filePath$ = "\(appPath$)/vinter.mp4"
      let videoURLⓞ = NSURL(fileURLWithPath: "\(appPath$)/vinter.mp4")
      if (fileManagerⓞ.fileExistsAtPath(filePath$)) { print("TargetVC: Video Loaded") } else { print("\(filePath$) not found!"); return }
      playerⓞ = AVPlayer(URL: videoURLⓞ) // Initialize the player with the video indicated in the URL
      videoⓞ = playerⓞ.currentItem
      playerLayerⓞ = AVPlayerLayer(player: playerⓞ)
      playerLayerⓞ.frame = view.bounds
      view.layer.insertSublayer(playerLayerⓞ, atIndex: 0)
      notificationCenterⓞ.addObserver(self, selector: #selector(TargetVC.videoFinishedPlaying(_:)), name: AVPlayerItemDidPlayToEndTimeNotification, object: videoⓞ) // Notificates when the video reaches the end
      playerⓞ.play()
      status🅔 = .Playing
   }

// MARK: AVPlayer Delegate
   
   func videoFinishedPlaying(notification: NSNotification) { status🅔 = .Stopped ; videoAtEndⓑ = true }
   
// MARK: Gesture Recognizers & UI Response
   
   override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
      print("Touches Ended")
   }
   
   func initializeActiveTargets(depthLevel＃: Int = 0) {
      activeTargets﹙ⓞ🅐﹚＃🅓[depthLevel＃] = [TargetButtonIV?]()
      for _ in 0...maxTargetIndex＃ { activeTargets﹙ⓞ🅐﹚＃🅓[depthLevel＃]!.append(TargetButtonIV()) }
   }
   
   func spawnTarget(sender: UITapGestureRecognizer) {
      guard let newTargetIndex＃ = getAvailableTargetSocketⓞ＃🅓(currentDepthLevel＃) else { return }
      let tapPointⓖ² = sender.locationInView(view)
//      var imagesⓞ🅐 = [UIImage]() ; for imageIndex＃ in 0...imagesPerTarget＃ { imagesⓞ🅐.append(UIImage(named: "\(imageIndex＃).png")!) }
      let newTargetⓞ = TargetButtonIV(imageⓞ: targetImageⓞ!, alphaⓖ: targetAlphaⓖ, depthLevel＃: currentDepthLevel＃, index＃: newTargetIndex＃, coordinateⓖ²: tapPointⓖ², delegateⓞ: self, tapHandlerƒ: #selector(TargetVC.enterTarget), dragHandlerƒ: #selector(TargetVC.moveTarget) )
      newTargetⓞ.setFrame(widthⓖ: view.frame.width * targetSizeFactorⓖ, heightⓖ: view.frame.width * targetSizeFactorⓖ)
      newTargetⓞ.center = tapPointⓖ²
      activeTargets﹙ⓞ🅐﹚＃🅓[currentDepthLevel＃]![newTargetIndex＃] = newTargetⓞ
      view.addSubview(newTargetⓞ)
   }
   
   func getAvailableTargetSocketⓞ＃🅓(depthLevel＃: Int) -> Int? {
      if activeTargets﹙ⓞ🅐﹚＃🅓[depthLevel＃].isNilⓑ() { initializeActiveTargets(depthLevel＃) }
      for targetIndex＃ in 0...maxTargetIndex＃ { if activeTargets﹙ⓞ🅐﹚＃🅓[depthLevel＃]![targetIndex＃]!.level＃ == -1 { return targetIndex＃ } }
      return nil
   }
   
   func getLastActiveTarget(depthLevel＃: Int) -> TargetButtonIV? {
      for (index＃, targetⓞ) in activeTargets﹙ⓞ🅐﹚＃🅓[depthLevel＃]!.enumerate() {
         if index＃ > maxTargetIndex＃ { return nil }
         if targetⓞ.isNotNilⓑ() { return targetⓞ }
      }
      return nil
   }
   
   func enterTarget(sender: TargetTapGestureRecognizer) {
      HKUI＋.animation(duration＃: targetEnterDuration＃d, mainƒ: {
         activeTargets﹙ⓞ🅐﹚＃🅓[currentDepthLevel＃]![sender.targetNumber＃]!.setFrame(widthⓖ: self.view.frame.width * 3, heightⓖ: self.view.frame.width * 3)
         activeTargets﹙ⓞ🅐﹚＃🅓[currentDepthLevel＃]![sender.targetNumber＃]!.center = self.view.center
         activeTargets﹙ⓞ🅐﹚＃🅓[currentDepthLevel＃]![sender.targetNumber＃]!.alpha = 0
      }, completionƒ: {
         print("WARPED!!")
         self.navigationTreeⓞ.sink()
      })
      
   }
   
   func moveTarget(sender: TargetPanGestureRecognizer) {
//      let panPointⓖ² = sender.locationInView(view)
      let panVectorⓖ² = sender.translationInView(view)
      switch sender.state {
         case .Began:
            draggingTargetⓞ.setNil()
            draggingTargetⓞ = activeTargets﹙ⓞ🅐﹚＃🅓[currentDepthLevel＃]![sender.targetNumber＃]
         case .Changed where draggingTargetⓞ.isNotNilⓑ():
            draggingTargetⓞ!.center = CGPoint(x: draggingTargetⓞ!.center.x + panVectorⓖ².x, y: draggingTargetⓞ!.center.y + panVectorⓖ².y)
            sender.setTranslation(CGPointZero, inView: view)
         case .Ended: draggedTargetIVⓞ = nil
         default: break
      }
   }
   
   
   func deleteTarget(depthLevel＃: Int) {
   }
   
   
   func displayTargetButtons() {
      
   }
   
   
// MARK: ViewController Life-Cycle
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   
}
