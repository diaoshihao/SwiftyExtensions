//
//  UITextViewExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/26.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

class HYTextView: UITextView {
    lazy var placeholderLabel: UILabel? = {
        let placeholderLabel = UILabel()
        placeholderLabel.numberOfLines = 0
        placeholderLabel.font = font
        placeholderLabel.sizeToFit()
        placeholderLabel.textColor = .lightGray
        addSubview(placeholderLabel)
        if #available(iOS 8.0, *) {
            setValue(placeholderLabel, forKey: "_placeholderLabel")
        }
        return placeholderLabel
    }()
    
    var placeholder: String? {
        set {
            placeholderLabel?.text = newValue
            placeholderLabel?.sizeToFit()
        }
        get {
            return placeholderLabel?.text
        }
    }
    
    override var font: UIFont? {
        didSet {
            placeholderLabel?.font = font
            placeholderLabel?.sizeToFit()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if placeholder != nil {
            placeholderLabel?.frame.origin = CGPoint(x: textContainer.lineFragmentPadding, y: textContainer.lineFragmentPadding)
        }
    }
}


extension UITextView {
    /// 清空
    func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    
    /// 滚动到底部
    func scrollToBottom() {
        let range = NSMakeRange((text as NSString).length - 1, 1)
        scrollRangeToVisible(range)
    }
    
    /// 滚动到顶部
    func scrollToTop() {
        let range = NSMakeRange(0, 1)
        scrollRangeToVisible(range)
    }
}
