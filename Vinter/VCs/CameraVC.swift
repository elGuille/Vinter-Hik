//
//  CamVC.swift
//  Vinter
//
//  Created by Guillermo García on 29/07/16.
//  Copyright © 2016 Vinter. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary

class CameraVC: UIViewController, AVCaptureFileOutputRecordingDelegate {
   
   @IBOutlet weak var recCircleIV﹫: UIImageView!
   @IBOutlet weak var recRecIV﹫: UIImageView!
   @IBOutlet weak var finishButton﹫: UIButton!
   
   enum Status🅔 { case Recording, Stopped, Error }
   
   var statusⓑ: Status🅔 = .Stopped
   var vinterCamⓞ: VinterCam!
   var maxDuration＃: NSTimeInterval = 120
   var stopRequestedⓑ = NO
   
   override func viewDidLoad() {
      super.viewDidLoad()
      vinterCamⓞ = VinterCam(superViewⓞ: view, recDelegateⓞ: self, videoFileName$: "vinter")
   }
   
   @IBAction func screenTapped(sender: AnyObject) {
      switch vinterCamⓞ.status🅔 {
         case .Stopped:
            startREC()
            vinterCamⓞ.rec()
            if !stopRequestedⓑ { sendDelayedStop(maxDuration＃) }
         case .Recording:
            stopREC()
            vinterCamⓞ.stop()
      }
   }
   
   func startREC() {
      recCircleIV﹫.hidden = NO
      recRecIV﹫.hidden = NO
      finishButton﹫.hidden = YES
      startRecThrob()
   }
   
   func stopREC() {
      recCircleIV﹫.hidden = YES
      recRecIV﹫.hidden = YES
      finishButton﹫.hidden = NO
      stopRecThrob()
   }
   
   func startRecThrob() {
      UIView.animateWithDuration(0.5, delay: 0.0, options: [.Repeat, .Autoreverse, .AllowUserInteraction], animations: { () -> () in
         self.recCircleIV﹫.transform = CGAffineTransformMakeScale(0.5, 0.5)
         self.recRecIV﹫.alpha = 0
      }, completion: nil)
   }
   
   func stopRecThrob() {
      UIView.animateWithDuration(0.5, delay: 1.0, options: [], animations: { () -> () in
         self.recCircleIV﹫.transform = CGAffineTransformMakeScale(1.0, 1.0)
         self.recRecIV﹫.alpha = 1
      }, completion: nil)
      recCircleIV﹫.layer.removeAllAnimations()
   }
   
   
   func sendDelayedStop(delay: NSTimeInterval) {
      HKThreading＋.LAUNCH_THREAD_MAIN_Q(delayInSeconds＃: delay, bodyƒ: {
         if self.vinterCamⓞ.status🅔 == .Stopped { return }
         self.vinterCamⓞ.stop()
         self.stopRecThrob()
         self.stopREC()
      }, completionƒ: { self.stopRequestedⓑ = NO })
   }
   
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   // this delegate function is not needed to pick up the video because it's being saved
   
   
   
   func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
      print("CameraVC: VIDEO RECORDED")
      //      let assetsLib = ALAssetsLibrary()
      //      assetsLib.writeVideoAtPathToSavedPhotosAlbum(outputFileURL, completionBlock: nil)
   }
   
   
   //   @IBAction func shareButtonTapped(sender: AnyObject) {
   //      let videoURL = NSURL(fileURLWithPath: vinterCamⓞ.filePath$)
   //      let objectsToShare = [videoURL]
   //      let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
   //      presentViewController(activityViewController, animated: YES, completion: { self.setButtonsToRecMode() })
   //   }
   
   
   /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
   
}
