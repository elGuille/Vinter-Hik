//
//  VinterCam.swift
//  Vinter
//
//  Created by Guillermo García on 28/07/16.
//  Copyright © 2016 Vinter. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary

class VinterCam {
   
   enum Status🅔 { case Recording, Stopped }
   var status🅔: Status🅔 = .Stopped
   weak var delegateⓞ: AVCaptureFileOutputRecordingDelegate?
   let videoFileName$: String
   var atStartⓑ = false
   var atEndⓑ = false
   var filePath$: String { return "\(appPath$)/\(videoFileName$).mp4" }
   
   var captureSessionⓞ: AVCaptureSession?
   let fileOutputⓞ = AVCaptureMovieFileOutput()
   
   init(superViewⓞ view: UIView, recDelegateⓞ: AVCaptureFileOutputRecordingDelegate, videoFileName$: String) {
      delegateⓞ = recDelegateⓞ
      self.videoFileName$ = videoFileName$
      let captureSessionⓞ = AVCaptureSession() //; captureSessionⓞ.sessionPreset = AVCaptureSessionPreset640x480 // MUST USE THE GLOBAL ONE
      let videoDeviceⓞ = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
      let audioDeviceⓞ = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
      let videoInputⓞ = try! AVCaptureDeviceInput(device: videoDeviceⓞ) //as AVCaptureDeviceInput
      captureSessionⓞ.addInput(videoInputⓞ)
      let audioInputⓞ = try! AVCaptureDeviceInput(device: audioDeviceⓞ) as AVCaptureInput
      captureSessionⓞ.addInput(audioInputⓞ)
      captureSessionⓞ.addOutput(fileOutputⓞ)
      let videoLayerⓞ = AVCaptureVideoPreviewLayer(session: captureSessionⓞ) //as AVCaptureVideoPreviewLayer
      videoLayerⓞ.videoGravity = AVLayerVideoGravityResizeAspectFill
      videoLayerⓞ.frame = view.bounds
      view.layer.insertSublayer(videoLayerⓞ, atIndex: 0)
      captureSessionⓞ.startRunning()
   }
   
   func rec() {
      status🅔 = .Recording
      let fileURLⓞ = NSURL(fileURLWithPath: filePath$)
      fileOutputⓞ.startRecordingToOutputFileURL(fileURLⓞ, recordingDelegate: delegateⓞ)
   }
   
   func stop() {
      status🅔 = .Stopped
      fileOutputⓞ.stopRecording()
   }
   
//   private func screenshotCMTime(cmTime: CMTime) throws -> (UIImage, photoTime: CMTime)? {
//      guard let player = player , let asset = player.currentItem?.asset else {
//         return nil
//      }
//      let imageGenerator = AVAssetImageGenerator(asset: asset)
//      
//      var timePicture = CMTime.zero
//      imageGenerator.appliesPreferredTrackTransform = true
//      imageGenerator.requestedTimeToleranceAfter = CMTime.zero
//      imageGenerator.requestedTimeToleranceBefore = CMTime.zero
//      
//      let ref = try imageGenerator.copyCGImageAtTime(cmTime, actualTime: &timePicture)
//      let viewImage: UIImage = UIImage(CGImage: ref)
//      return (viewImage, timePicture)
//   }
   
   
//   deinit { captureSession!.stopRunning()
   
}






