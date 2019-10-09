//
//  DictionaryExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/25.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import Foundation

//==============================================================
//MARK: - Properties
//==============================================================
public extension Dictionary {
    
    /// 是否有 key
    ///
    /// - Parameter key: 搜索的 key
    /// - Returns: 有 key 返回 true
    func has(_ key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    /// 字典转 json data
    ///
    /// - Parameter prettify: 是否打印偏好
    /// - Returns: json data 或 nil
    func jsonData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options: JSONSerialization.WritingOptions = prettify ? .prettyPrinted : JSONSerialization.WritingOptions()
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
    
    /// 字典转 json 字符串
    ///
    /// - Parameter prettify: 是否打印偏好
    /// - Returns: json 字符串 或 nil
    func jsonString(prettify: Bool = false) -> String? {
        guard let data = jsonData(prettify: prettify) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
