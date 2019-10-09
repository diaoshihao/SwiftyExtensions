//
//  UIColorExtension.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/17.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /// 十六进制数生成颜色
    ///
    /// - Parameters:
    ///   - hex: 十六进制数
    ///   - alpha: 透明度，默认 1.0
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 十六进制字符串生成颜色，必须是 0x 或者 0X 开头
    ///
    /// - Parameters:
    ///   - hexString: 十六进制数字符串
    ///   - alpha: 透明度，默认 1.0
    convenience init(from hexString: String, alpha: CGFloat = 1.0) {
        let hex = UnsafeMutablePointer<UInt64>.allocate(capacity: 1)
        Scanner(string: hexString).scanHexInt64(hex)
        self.init(hex: Int(hex.pointee), alpha: alpha)
    }
    
}
