//
//  SwiftEntryKitAttributes.swift
//  PLCFarm
//
//  Created by dima on 9/30/19.
//  Copyright © 2019 PLC Group AG. All rights reserved.
//

import SwiftEntryKit

public struct SwiftEntryKitAttributes {
    
    public static var popup: EKAttributes {
        var attributes                          = EKAttributes.centerFloat
        attributes.displayDuration              = .infinity
        attributes.screenInteraction            = .absorbTouches
        attributes.entryInteraction             = .absorbTouches
        attributes.scroll                       = .disabled 
        attributes.entranceAnimation            = .none
        attributes.exitAnimation                = .none
        attributes.screenBackground             = .color(color: EKColor.black.with(alpha: 0.3))
//        attributes.screenBackground             = .color(color: UIColor(white: 50.0/255.0, alpha: 0.3))
        attributes.positionConstraints.size     = .init(width: .offset(value: 20),
                                                        height: .intrinsic)
        attributes.positionConstraints.maxSize  = .init(width: .constant(value: UIScreen.main.minEdge),
                                                        height: .intrinsic)
        return attributes
    }
    
    public static var modal: EKAttributes {
        return EKAttributes()
    }
    
    public static var notification: EKAttributes {
        return EKAttributes()
    }
    
}
