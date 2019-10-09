//
//  UIViewExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/24.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

//==============================================================
//MARK: enums
//==============================================================
public extension UIView {
    
    /// view 的晃动方向
    ///
    /// - horizontal: 水平方向（左右）
    /// - vertical: 垂直方向（上下）
    enum ShakeDirection {
        case horizontal
        case vertical
    }
    
    /// view 的角度单位
    ///
    /// - degrees: degrees.
    /// - radians: radians.
    
    enum AngleUnit {
        /// degrees.
        case degrees
        
        /// radians.
        case radians
    }
    
    /// 晃动动画类型
    ///
    /// - linear: linear animation.
    /// - easeIn: easeIn animation.
    /// - easeOut: easeOut animation.
    /// - easeInOut: easeInOut animation.
    enum ShakeAnimationType {
        /// linear animation.
        case linear
        
        /// easeIn animation.
        case easeIn
        
        /// easeOut animation.
        case easeOut
        
        /// easeInOut animation.
        case easeInOut
    }
    
}

// MARK: - Properties
public extension UIView {
    
    /// 边框颜色，支持 Storyboard
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    /// 边框宽度，支持 Storyboard
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// 圆角大小，支持 Storyboard
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    /// 阴影颜色，支持 Storyboard
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    /// 阴影偏移，支持 Storyboard
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /// 阴影透明度，支持 Storyboard
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /// 阴影圆角，支持 Storyboard
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    
    /// 截屏图片
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 控制器
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
}

public extension UIView {
    /// view 宽度
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    /// view 高度
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    /// view x坐标
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// view y坐标
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    /// view 大小
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
}

// MARK: - Methods
public extension UIView {
    
    /// 第一响应者
    func firstResponder() -> UIView? {
        var views = [UIView](arrayLiteral: self)
        var index = 0
        repeat {
            let view = views[index]
            if view.isFirstResponder {
                return view
            }
            views.append(contentsOf: view.subviews)
            index += 1
        } while index < views.count
        return nil
    }
    
    /// 设置多个或所有圆角
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    /// 添加阴影
    ///
    /// - Parameters:
    ///   - color: shadow color (default is #137992).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5).
    func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    /// 添加子视图数组
    ///
    /// - Parameter subviews: array of subviews to add to self.
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
    /// 通过 Fade in 模式显示
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    func fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: completion)
    }
    
    /// 通过 Fade out 模式显示
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    func fadeOut(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: completion)
    }
    
    /// 从 nib 加载视图
    ///
    /// - Parameters:
    ///   - name: nib name.
    ///   - bundle: bundle of nib (default is nil).
    /// - Returns: optional UIView (if applicable).
    class func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    /// 移除所有子视图
    func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    /// 移除所有手势
    func removeGestureRecognizers() {
        gestureRecognizers?.forEach(removeGestureRecognizer)
    }
    
    /// 添加手势
    ///
    /// Attaching gesture recognizers to a view defines the scope of the represented
    /// gesture, causing it to receive touches hit-tested to that view and all of its
    /// subviews. The view establishes a strong reference to the gesture recognizers.
    ///
    /// - Parameter gestureRecognizers: The array of gesture recognizers to be added to the view.
    func addGestureRecognizers(_ gestureRecognizers: [UIGestureRecognizer]) {
        for recognizer in gestureRecognizers {
            addGestureRecognizer(recognizer)
        }
    }
    
    /// 移除数组中的所有手势
    ///
    /// This method releases gestureRecognizers in addition to detaching them from the view.
    ///
    /// - Parameter gestureRecognizers: The array of gesture recognizers to be removed from the view.
    func removeGestureRecognizers(_ gestureRecognizers: [UIGestureRecognizer]) {
        for recognizer in gestureRecognizers {
            removeGestureRecognizer(recognizer)
        }
    }
    
    /// 旋转视图（相对角度）
    ///
    /// - Parameters:
    ///   - angle: angle to rotate view by.
    ///   - type: type of the rotation angle.
    ///   - animated: set true to animate rotation (default is true).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func rotate(byAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.transform = self.transform.rotated(by: angleWithType)
        }, completion: completion)
    }
    
    /// 旋转视图（绝对角度）
    ///
    /// - Parameters:
    ///   - angle: angle to rotate view to.
    ///   - type: type of the rotation angle.
    ///   - animated: set true to animate rotation (default is false).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func rotate(toAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, animations: {
            self.transform = self.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
        }, completion: completion)
    }
    
    /// 视图缩放
    ///
    /// - Parameters:
    ///   - offset: scale offset
    ///   - animated: set true to animate scaling (default is false).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
                self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
            }, completion: completion)
        } else {
            transform = transform.scaledBy(x: offset.x, y: offset.y)
            completion?(true)
        }
    }
    
    /// 视图晃动
    ///
    /// - Parameters:
    ///   - direction: shake direction (horizontal or vertical), (default is .horizontal)
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - animationType: shake animation type (default is .easeOut).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func shake(direction: ShakeDirection = .horizontal, duration: TimeInterval = 1, animationType: ShakeAnimationType = .easeOut, completion:(() -> Void)? = nil) {
        CATransaction.begin()
        let animation: CAKeyframeAnimation
        switch direction {
        case .horizontal:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        case .vertical:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        }
        switch animationType {
        case .linear:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        case .easeIn:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        case .easeOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        case .easeInOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        }
        CATransaction.setCompletionBlock(completion)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
    
    /// 约束铺满父视图
    @available(iOS 9, *)
    func fillToSuperview() {
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
    
    /// 添加约束
    ///
    /// - Parameters:
    ///   - top: current view's top anchor will be anchored into the specified anchor
    ///   - left: current view's left anchor will be anchored into the specified anchor
    ///   - bottom: current view's bottom anchor will be anchored into the specified anchor
    ///   - right: current view's right anchor will be anchored into the specified anchor
    ///   - topConstant: current view's top anchor margin
    ///   - leftConstant: current view's left anchor margin
    ///   - bottomConstant: current view's bottom anchor margin
    ///   - rightConstant: current view's right anchor margin
    ///   - widthConstant: current view's width
    ///   - heightConstant: current view's height
    /// - Returns: array of newly added constraints (if applicable).
    @available(iOS 9, *)
    @discardableResult
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        rightConstant: CGFloat = 0,
        widthConstant: CGFloat = 0,
        heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    /// 添加垂直居中约束
    ///
    /// - Parameter constant: constant of the anchor constraint (default is 0).
    @available(iOS 9, *)
    func anchorCenterXToSuperview(constant: CGFloat = 0) {
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    /// 添加水平居中约束
    ///
    /// - Parameter withConstant: constant of the anchor constraint (default is 0).
    @available(iOS 9, *)
    func anchorCenterYToSuperview(constant: CGFloat = 0) {
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    /// 添加居中约束
    @available(iOS 9, *)
    func anchorCenterSuperview() {
        // https://videos.letsbuildthatapp.com/
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
    
    /// 在父视图链中寻找符合条件的 view
    ///
    /// - Parameter predicate: predicate to evaluate on superviews.
    func ancestorView(where predicate: (UIView?) -> Bool) -> UIView? {
        if predicate(superview) {
            return superview
        }
        return superview?.ancestorView(where: predicate)
    }
    
    /// 在父视图链中寻找对应类的 view
    ///
    /// - Parameter name: class of the view to search.
    func ancestorView<T: UIView>(withClass name: T.Type) -> T? {
        return ancestorView(where: { $0 is T }) as? T
    }
    
}

//==============================================================
//MARK: - Auto Layout
//==============================================================
public extension UIView {
    enum AnchorType {
        
        case edgeEqual(UIEdgeInsets)
        
        case topEqualTo(NSLayoutYAxisAnchor, CGFloat)
        case topLessThanTo(NSLayoutYAxisAnchor, CGFloat)
        case topGreaterThanTo(NSLayoutYAxisAnchor, CGFloat)
        
        case leftEqualTo(NSLayoutXAxisAnchor, CGFloat)
        case leftLessThanTo(NSLayoutXAxisAnchor, CGFloat)
        case leftGreaterThanTo(NSLayoutXAxisAnchor, CGFloat)
        
        case rightEqualTo(NSLayoutXAxisAnchor, CGFloat)
        case rightLessThanTo(NSLayoutXAxisAnchor, CGFloat)
        case rightGreaterThanTo(NSLayoutXAxisAnchor, CGFloat)
        
        case bottomEqualTo(NSLayoutYAxisAnchor, CGFloat)
        case bottomLessThanTo(NSLayoutYAxisAnchor, CGFloat)
        case bottomGreaterThanTo(NSLayoutYAxisAnchor, CGFloat)
        
        case widthEqual(CGFloat)
        case widthLessThan(CGFloat)
        case widthGreaterThan(CGFloat)
        
        case heightEqual(CGFloat)
        case heightLessThan(CGFloat)
        case heightGreaterThan(CGFloat)
        
        case widthEqualTo(NSLayoutDimension, CGFloat)
        case widthLessThanTo(NSLayoutDimension, CGFloat)
        case widthGreaterThanTo(NSLayoutDimension, CGFloat)
        
        case heightEqualTo(NSLayoutDimension, CGFloat)
        case heightLessThanTo(NSLayoutDimension, CGFloat)
        case heightGreaterThanTo(NSLayoutDimension, CGFloat)
        
        case centerEqualToSuperview
        
        case centerXEqualSuperview(CGFloat)
        case centerXLessThanSuperview(CGFloat)
        case centerXGreaterThanSuperview(CGFloat)
        
        case centerXEqualTo(NSLayoutXAxisAnchor, CGFloat)
        case centerXLessThanTo(NSLayoutXAxisAnchor, CGFloat)
        case centerXGreaterThanTo(NSLayoutXAxisAnchor, CGFloat)
        
        case centerYEqualSuperview(CGFloat)
        case centerYLessThanSuperview(CGFloat)
        case centerYGreaterThanSuperview(CGFloat)
        
        case centerYEqualTo(NSLayoutYAxisAnchor, CGFloat)
        case centerYLessThanTo(NSLayoutYAxisAnchor, CGFloat)
        case centerYGreaterThanTo(NSLayoutYAxisAnchor, CGFloat)
    }
    
    func anchor(type: AnchorType, isActive: Bool = true) {
        if superview == nil {
            fatalError("请先将 view 添加到 superview！")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        switch type {
            
        case let .edgeEqual(edge):
            topAnchor.constraint(equalTo: superview!.topAnchor, constant: edge.top).isActive = isActive
            leftAnchor.constraint(equalTo: superview!.leftAnchor, constant: edge.left).isActive = isActive
            rightAnchor.constraint(equalTo: superview!.rightAnchor, constant: edge.right).isActive = isActive
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: edge.bottom).isActive = isActive
            
        case let .topEqualTo(top, constant):
            topAnchor.constraint(equalTo: top, constant: constant).isActive = isActive
        case let .topLessThanTo(top, constant):
            topAnchor.constraint(lessThanOrEqualTo: top, constant: constant).isActive = isActive
        case let .topGreaterThanTo(top, constant):
            topAnchor.constraint(greaterThanOrEqualTo: top, constant: constant).isActive = isActive
            
        case let .leftEqualTo(left, constant):
            leftAnchor.constraint(equalTo: left, constant: constant).isActive = isActive
        case let .leftLessThanTo(left, constant):
            leftAnchor.constraint(lessThanOrEqualTo: left, constant: constant).isActive = isActive
        case let .leftGreaterThanTo(left, constant):
            leftAnchor.constraint(greaterThanOrEqualTo: left, constant: constant).isActive = isActive
            
        case let .rightEqualTo(right, constant):
            rightAnchor.constraint(equalTo: right, constant: constant).isActive = isActive
        case let .rightLessThanTo(right, constant):
            rightAnchor.constraint(lessThanOrEqualTo: right, constant: constant).isActive = isActive
        case let .rightGreaterThanTo(right, constant):
            rightAnchor.constraint(greaterThanOrEqualTo: right, constant: constant).isActive = isActive
            
        case let .bottomEqualTo(bottom, constant):
            bottomAnchor.constraint(equalTo: bottom, constant: constant).isActive = isActive
        case let .bottomLessThanTo(bottom, constant):
            bottomAnchor.constraint(lessThanOrEqualTo: bottom, constant: constant).isActive = isActive
        case let .bottomGreaterThanTo(bottom, constant):
            bottomAnchor.constraint(greaterThanOrEqualTo: bottom, constant: constant).isActive = isActive
            
        case let .widthEqual(constant):
            widthAnchor.constraint(equalToConstant: constant).isActive = isActive
        case let .widthLessThan(constant):
            widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = isActive
        case let .widthGreaterThan(constant):
            widthAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = isActive
            
        case let .heightEqual(constant):
            heightAnchor.constraint(equalToConstant: constant).isActive = isActive
        case let .heightLessThan(constant):
            heightAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = isActive
        case let .heightGreaterThan(constant):
            heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = isActive
            
        case let .widthEqualTo(dimension, constant):
            widthAnchor.constraint(equalTo: dimension, constant: constant).isActive = isActive
        case let .widthLessThanTo(dimension, constant):
            widthAnchor.constraint(lessThanOrEqualTo: dimension, constant: constant).isActive = isActive
        case let .widthGreaterThanTo(dimension, constant):
            widthAnchor.constraint(greaterThanOrEqualTo: dimension, constant: constant).isActive = isActive
            
        case let .heightEqualTo(dimension, constant):
            heightAnchor.constraint(equalTo: dimension, constant: constant).isActive = isActive
        case let .heightLessThanTo(dimension, constant):
            heightAnchor.constraint(lessThanOrEqualTo: dimension, constant: constant).isActive = isActive
        case let .heightGreaterThanTo(dimension, constant):
            heightAnchor.constraint(greaterThanOrEqualTo: dimension, constant: constant).isActive = isActive
            
        case .centerEqualToSuperview:
            if let xAnchor = superview?.centerXAnchor, let yAnchor = superview?.centerYAnchor {
                centerXAnchor.constraint(equalTo: xAnchor).isActive = isActive
                centerYAnchor.constraint(equalTo: yAnchor).isActive = isActive
            }
            
        case let .centerXEqualSuperview(constant):
            if let xAnchor = superview?.centerXAnchor {
                centerXAnchor.constraint(equalTo: xAnchor, constant: constant).isActive = isActive
            }
        case let .centerXLessThanSuperview(constant):
            if let xAnchor = superview?.centerXAnchor {
                centerXAnchor.constraint(lessThanOrEqualTo: xAnchor, constant: constant).isActive = isActive
            }
        case let .centerXGreaterThanSuperview(constant):
            if let xAnchor = superview?.centerXAnchor {
                centerXAnchor.constraint(greaterThanOrEqualTo: xAnchor, constant: constant).isActive = isActive
            }
            
        case let .centerXEqualTo(xAnchor, constant):
            centerXAnchor.constraint(equalTo: xAnchor, constant: constant).isActive = isActive
        case let .centerXLessThanTo(xAnchor, constant):
            centerXAnchor.constraint(lessThanOrEqualTo: xAnchor, constant: constant).isActive = isActive
        case let .centerXGreaterThanTo(xAnchor, constant):
            centerXAnchor.constraint(greaterThanOrEqualTo: xAnchor, constant: constant).isActive = isActive
            
        case let .centerYEqualSuperview(constant):
            if let yAnchor = superview?.centerYAnchor {
                centerYAnchor.constraint(equalTo: yAnchor, constant: constant).isActive = isActive
            }
        case let .centerYLessThanSuperview(constant):
            if let yAnchor = superview?.centerYAnchor {
                centerYAnchor.constraint(lessThanOrEqualTo: yAnchor, constant: constant).isActive = isActive
            }
        case let .centerYGreaterThanSuperview(constant):
            if let yAnchor = superview?.centerYAnchor {
                centerYAnchor.constraint(greaterThanOrEqualTo: yAnchor, constant: constant).isActive = isActive
            }
            
        case let .centerYEqualTo(yAnchor, constant):
            centerYAnchor.constraint(equalTo: yAnchor, constant: constant).isActive = isActive
        case let .centerYLessThanTo(yAnchor, constant):
            centerYAnchor.constraint(lessThanOrEqualTo: yAnchor, constant: constant).isActive = isActive
        case let .centerYGreaterThanTo(yAnchor, constant):
            centerYAnchor.constraint(greaterThanOrEqualTo: yAnchor, constant: constant).isActive = isActive
        }
    }
}
