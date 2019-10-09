//
//  UIWindowExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/24.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

// MARK: - Methods
public extension UIWindow {
    
    /// 重置根视图控制器
    ///
    /// - Parameters:
    ///   - viewController: 视图控制器
    ///   - duration: 动画时间，默认 0
    ///   - options: 动画选项
    ///   - completion: 重置完成
    func resetRootViewController(root viewController: UIViewController,
                                  duration: TimeInterval = 0,
                                  options: UIView.AnimationOptions = .transitionFlipFromRight,
                                  _ completion: (() -> Void)? = nil) {
        guard duration > 0 else {
            rootViewController = viewController
            completion?()
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) { (isComplete) in
            if isComplete {
                completion?()
            }
        }
    }
}
