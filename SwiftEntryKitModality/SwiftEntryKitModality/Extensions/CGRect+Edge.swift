//
//  CGRect+Edge.swift
//  SwiftEntryKitModality
//
//  Created by dima on 10/22/19.
//  Copyright © 2019 QuilCode. All rights reserved.
//

import UIKit

extension CGRect {
    
    var minEdge: CGFloat {
        return min(width, height)
    }
    
}


