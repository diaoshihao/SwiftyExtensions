//
//  UIImageExtension.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/17.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /// 通过颜色创建图片
    ///
    /// - Parameters:
    ///   - color: 图片填充色
    ///   - size: 图片大小
    /// - Returns: 填充对应颜色的图片
    static func image(color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 获取 view 的截图
    ///
    /// - Parameter view: 需要截图的 view
    /// - Returns: view 的截图
    static func image(from view: UIView) -> UIImage? {
        UIGraphicsBeginImageContext(view.bounds.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            view.layer.render(in: currentContext)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image;
        }
        return nil;
    }
}
