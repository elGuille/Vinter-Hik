//
//  VinterCam.swift
//  Vinter
//
//  Created by Guillermo García on 28/07/16.
//  Copyright © 2016 Vinter. All rights reserved.
//

import AVFoundation
import UIKit

class VinterCam { // This class records videos

    enum Status🅔 { case recording, stopped }
    var status🅔: Status🅔 = .stopped
    weak var delegateⓄ: AVCaptureFileOutputRecordingDelegate?
    let videoFileName$: String
    var atStartⓑ = false
    var atEndⓑ = false
    var filePath$: String { return "\(appPath$)/\(videoFileName$).mp4" }
    
    var captureSession: AVCaptureSession?
    let fileOutputⓄ = AVCaptureMovieFileOutput()
    
    init(superViewⓄ view: UIView, recDelegateⓄ: AVCaptureFileOutputRecordingDelegate, videoFileName$: String) {
        delegateⓄ = recDelegateⓄ
        self.videoFileName$ = videoFileName$
        let captureSessionⓄ = AVCaptureSession()
        let videoDeviceⓄ = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let audioDeviceⓄ = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
        let videoInputⓄ = try! AVCaptureDeviceInput(device: videoDeviceⓄ) //as AVCaptureDeviceInput
        captureSessionⓄ.addInput(videoInputⓄ)
        let audioInput = try! AVCaptureDeviceInput(device: audioDeviceⓄ) as AVCaptureInput
        captureSessionⓄ.addInput(audioInput)
        captureSessionⓄ.addOutput(fileOutputⓄ)
        let videoLayerⓄ = AVCaptureVideoPreviewLayer(session: captureSessionⓄ) //as AVCaptureVideoPreviewLayer
        videoLayerⓄ?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoLayerⓄ?.frame = view.bounds
        view.layer.insertSublayer(videoLayerⓄ!, at: 0)
        captureSessionⓄ.startRunning()
    }
    
    func rec() {
        status🅔 = .recording
        let fileURL = URL(fileURLWithPath: filePath$)
        fileOutputⓄ.startRecording(toOutputFileURL: fileURL, recordingDelegate: delegateⓄ)
        print("RECORDING...")
    }
    
    func stop() {
        status🅔 = .stopped
        fileOutputⓄ.stopRecording()
        print("STOPPED!")
    }
    

    
    //   deinit { captureSession!.stopRunning()
    
}






