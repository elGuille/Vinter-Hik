//
//  DataModel.swift
//  Vinter
//
//  Created by Guillermo García on 20/07/16.
//  Copyright © 2016 Vinter. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Userⓞ {
   var email$: String
   var password$: String
   var profilePicⓞ: UIImage?
   
   init(email: String, password: String, profilePicⓞ: UIImage?) {
      self.email$ = email
      self.password$ = password
      self.profilePicⓞ = profilePicⓞ
   }
}


class Post {
   var id$: String
   var title$: String
   var vinterⓞ: Vinter
   
   init(id$: String, title$: String, vinterⓞ: Vinter) {
      self.id$ = id$
      self.title$ = title$
      self.vinterⓞ = vinterⓞ
   }
}


class Vinter {
   var videoPath$: String
   var vinterPointersⓞ🅐: [VinterPointer] // Maximum 5
   
   init(videoPath$: String, vinterPointersⓞ🅐: [VinterPointer]) {
      self.videoPath$ = videoPath$
      self.vinterPointersⓞ🅐 = vinterPointersⓞ🅐
   }
}


class VinterPointer {
   var overlay: UIImage
   var videoPath: String
   
   init(overlayImageⓞ: UIImage, videoPath$: String) {
      self.overlay = overlayImageⓞ
      self.videoPath = videoPath$
   }
}
