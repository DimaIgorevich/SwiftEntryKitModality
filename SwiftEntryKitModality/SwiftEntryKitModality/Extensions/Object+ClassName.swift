//
//  Object+ClassName.swift
//  SwiftEntryKitModality
//
//  Created by dima on 10/22/19.
//  Copyright © 2019 QuilCode. All rights reserved.
//

import Foundation

public extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
    
}
