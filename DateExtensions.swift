//
//  DateExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/25.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import Foundation

public extension Date {
    
    /// 时间格式化字符串
    ///
    /// - Parameter format: 时间格式
    /// - Returns: 格式化后的字符串
    func string(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
