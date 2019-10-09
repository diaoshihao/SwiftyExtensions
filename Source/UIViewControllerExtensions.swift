//
//  UIViewControllerExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/24.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

//==============================================================
//MARK: - Properties
//==============================================================
public extension UIViewController {
    
    /// 检查控制器是否显示在屏幕上
    var isVisible: Bool {
        return isViewLoaded && view.window != nil
    }
    
}

//==============================================================
//MARK: - Methods
//==============================================================
public extension UIViewController {
    
    /// 注册通知
    ///
    /// - Parameters:
    ///   - name: 通知名称
    ///   - selector: 通知事件
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    /// 移除通知
    ///
    /// - Parameter name: 通知名称
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    /// 移除所有通知
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    /// 显示系统弹窗
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 信息
    ///   - actionTitles: 按钮标题，空则显示“确定”按钮
    ///   - preferIndex: 高亮按钮下标
    ///   - completion: 点击按钮
    /// - Returns: UIAlertController
    @discardableResult
    func alert(title: String?, message: String?, actionTitles: [String]? = nil, preferIndex: Int? = nil, completion: ((UIAlertAction, Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var titles = actionTitles ?? []
        if titles.count == 0 {
            titles.append("确定")
        }
        
        for index in 0 ..< titles.count {
            let action = UIAlertAction(title: titles[index], style: .default, handler: { (action) in
                completion?(action, index)
            })
            alertController.addAction(action)
            
            if let preferIndex = preferIndex, index == preferIndex {
                alertController.preferredAction = action
            }
        }
        
        present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    /// 添加子视图控制器
    ///
    /// - Parameters:
    ///   - child: 子视图控制器
    ///   - containerView: 子视图控制器 view 容器
    func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /// 从父控制器中移除自身控制器及 view
    func removeViewAndControllerFromParentViewController() {
        guard parent != nil else { return }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    #if os(iOS)
    /// HYLibrary: Helper method to present a UIViewController as a popover.
    ///
    /// - Parameters:
    ///   - popoverContent: the view controller to add as a popover.
    ///   - sourcePoint: the point in which to anchor the popover.
    ///   - size: the size of the popover. Default uses the popover preferredContentSize.
    ///   - delegate: the popover's presentationController delegate. Default is nil.
    ///   - animated: Pass true to animate the presentation; otherwise, pass false.
    ///   - completion: The block to execute after the presentation finishes. Default is nil.
    func presentPopover(_ popoverContent: UIViewController, sourcePoint: CGPoint, size: CGSize? = nil, delegate: UIPopoverPresentationControllerDelegate? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        popoverContent.modalPresentationStyle = .popover
        
        if let size = size {
            popoverContent.preferredContentSize = size
        }
        
        if let popoverPresentationVC = popoverContent.popoverPresentationController {
            popoverPresentationVC.sourceView = view
            popoverPresentationVC.sourceRect = CGRect(origin: sourcePoint, size: .zero)
            popoverPresentationVC.delegate = delegate
        }
        
        present(popoverContent, animated: animated, completion: completion)
    }
    #endif
    
}

