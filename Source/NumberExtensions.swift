//
//  NumberExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/25.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import CoreGraphics

public extension Int {
    var uInt: UInt {
        return UInt(self)
    }
    
    var float: Float {
        return Float(self)
    }
    
    var double: Double {
        return Double(self)
    }
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    var string: String {
        return String(self)
    }
}

public extension Float {
    var int: Int {
        return Int(self)
    }
    
    var double: Double {
        return Double(self)
    }
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    var string: String {
        return String(self)
    }
}

public extension Double {
    var int: Int {
        return Int(self)
    }
    
    var float: Float {
        return Float(self)
    }
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    var string: String {
        return String(self)
    }
}

public extension CGFloat {
    var int: Int {
        return Int(self)
    }
    
    var float: Float {
        return Float(self)
    }
    
    var double: Double {
        return Double(self)
    }
    
    var string: String {
        return String(self.float)
    }
}

public extension String {
    var int: Int {
        return Int(self) ?? 0
    }
    
    var float: Float {
        return Float(self) ?? 0.0
    }
    
    var double: Double {
        return Double(self) ?? 0.0
    }
    
    var cgFloat: CGFloat {
        return CGFloat(self.float)
    }
}

