//
//  DataExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/25.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import Foundation

public extension Data {
    
    /// data 转字符串
    ///
    /// - Parameter encoding: 编码格式，默认 utf8
    /// - Returns: 字符串 或 nil
    func string(encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    /// data 转 json 对象
    ///
    /// - Parameter options: 偏好
    /// - Returns: json 对象
    /// - Throws: 转换失败抛出错误
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }
}
