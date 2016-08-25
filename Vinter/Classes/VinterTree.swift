//
//  VinterTree.swift
//  Vinter
//
//  Created by Hikarus on 16/8/24.
//  Copyright © 2016 Hikarian. All rights reserved.
//

import Foundation

class VinterTree {
   
   static var currentNodeⓞ: VinterTree!
   static var branchesPerNode＃ = -1
   static var depth＃ = -1

   class func printTree(nodeⓞ: VinterTree? = nil) {
   
   }
   
   var title$ = "Root"
   var path$ = "0"
   var nodesⓞ🅐 = [VinterTree]()
   
   init(maxBranchesPerNode＃: Int = 1, maxDepth＃: Int = maxVinterDepth＃, title$: String, makeCurrentⓑ: Bool = NO) {
      if VinterTree.branchesPerNode＃ == -1 { VinterTree.branchesPerNode＃ = maxBranchesPerNode＃ }
      if VinterTree.depth＃ == -1 { VinterTree.depth＃ = maxDepth＃ }
      self.title$ = title$
      if makeCurrentⓑ { VinterTree.currentNodeⓞ = self }
   }
   
   
   func insertNodeAtCurrent(title$: String, toNodeⓞ: VinterTree, makeCurrentⓑ: Bool = NO) {
      if toNodeⓞ.nodesⓞ🅐.count >= VinterTree.branchesPerNode＃ { print("ノドがいっぱい。追加出来ない") ; return }
      let newNodeⓞ = VinterTree(title$: title$, makeCurrentⓑ: makeCurrentⓑ)
      newNodeⓞ.path$ = path$ + String(nodesⓞ🅐.count)
      nodesⓞ🅐.append(newNodeⓞ)
   }
   
   func removeNodeFromCurrent(depth＃: Int, node＃: Int) {
      
   }
   
   func sink(node＃: Int) {
      if node＃ >= nodesⓞ🅐.count { print("そんな枝は存在しない。消すが出来ない") ; return }
//      if let nodeⓞ = nodesⓞ🅐
   }
   
   func rise() {
   
   }
   
}