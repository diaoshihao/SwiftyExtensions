//
//  StringExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/18.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import Foundation

//==============================================================
//MARK: - Properties
//==============================================================
public extension String {
    
    /// 正则匹配邮箱
    var isValidEmail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    /// 正则匹配手机号（中国）
    var isValidPhone: Bool {
        let regex = "^(13[0-9]|14[57]|15[012356789]|17[0678]|18[0-9])[0-9]{8}$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    /// 正则匹配 IP 地址
    var isValidIP: Bool {
        let regex = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    /// 正则匹配 URL
    var isValidURL: Bool {
        let regex = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

public extension String {
    
    /// 字符串转时间
    ///
    /// - Parameter format: 时间格式
    /// - Returns: Date
    func date(by format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}


public extension String {
    
    /// NSRange 转为 Range
    ///
    /// - Parameter range: NSRange
    /// - Returns: Range
    func range(from range: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}
