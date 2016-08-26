//
//  VinterTree.swift
//  Vinter
//
//  Created by Hikarus on 16/8/24.
//  Copyright © 2016 Hikarian. All rights reserved.
//

import Foundation

class VinterTree {
   
   typealias Nodeⓞⓞ🅣 = (targetⓞ: TargetButtonIV, nodeⓞ: VinterTree)
   static var currentNode: Nodeⓞⓞ🅣!
   static var currentDepthLevel＃ = 0
   
   var branchesPerNode＃ = 1
   var depth＃ = 1
   var nodesⓞ🅐 = [Nodeⓞⓞ🅣]()
   
   init(maxBranchesPerNode＃: Int, maxDepth: Int) {
      branchesPerNode＃ = maxBranchesPerNode＃
      depth＃ = maxDepth
   }
   
   func insertNode() {}
   func removeNode() {}
   func sink() {}
   func rise() {}
   
}