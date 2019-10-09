//
//  UIScrollViewExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/25.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

//==============================================================
//MARK: - Properties
//==============================================================
extension UIScrollView {
    
    /// 整个 scrollview 的截屏
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        let previousFrame = frame
        let previousOffset = contentOffset
        defer {
            UIGraphicsEndImageContext()
            frame = previousFrame
            contentOffset = previousOffset
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

//==============================================================
//MARK: - Methods
//==============================================================
public extension UIScrollView {
    
    /// 滑动到底部
    ///
    /// - Parameter animated: 是否动画
    func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    /// 滑动到顶部
    ///
    /// - Parameter animated: 是否动画
    func scrollToTop(animated: Bool = true) {
        setContentOffset(.zero, animated: animated)
    }
}
