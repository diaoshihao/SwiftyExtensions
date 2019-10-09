//
//  UIApplicationExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/26.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

public extension UIApplication {
    
    /// App 构建版本
    var buildNumber: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    /// App  版本号
    var version: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
