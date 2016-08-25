//
//  TargetTapGestureRecognizer.swift
//  Vinter
//
//  Created by Guillermo García on 10/08/16.
//  Copyright © 2016 Vinter. All rights reserved.
//

import UIKit

class TargetTapGestureRecognizer: UITapGestureRecognizer { var targetNumber＃: Int = 0 }

class TargetPanGestureRecognizer: UIPanGestureRecognizer { var targetNumber＃: Int = 0 }

class NavigationTapGestureRecognizer: UITapGestureRecognizer { var depthLevel＃: Int = 0 }