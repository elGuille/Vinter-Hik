//
//  Global.swift
//  Vinter
//
//  Created by Guillermo García on 22/07/16.
//  Copyright © 2016 Vinter. All rights reserved.
//

import Foundation
import UIKit
import AVKit

let shadowColorⓖ: CGFloat = 157.0 / 255.0
let appPaths$🅐 = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, YES)
let appPath$ = appPaths$🅐[0]

let maxVinterDepth＃ = 4
var currentDepthLevel＃ = 0
var activeTargets﹙ⓞ🅐﹚＃🅓 = [Int : [TargetButtonIV?]]()
let videoCompressionSetting$ = "AVCaptureSessionPreset640x480"

let maxTargetIndex＃ = 3
let maxVinterBranchIndex＃ = 3
let targetImageⓞ = UIImage(named: "Target.png")
let targetAlphaⓖ: CGFloat = 1
let imagesPerTarget＃ = 10
let targetSizeFactorⓖ: CGFloat = 0.14

let targetEnterDuration＃d: NSTimeInterval = 0.7

var screenShortestDimensionⓖ: CGFloat { return appⓞ.windows[0].frame.width < appⓞ.windows[0].frame.height ? appⓞ.windows[0].frame.width : appⓞ.windows[0].frame.height }