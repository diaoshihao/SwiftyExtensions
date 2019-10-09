//
//  UITableViewExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/25.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

//==============================================================
//MARK: - Properties
//==============================================================

public extension UITableView {
    
    /// tableview 最后一个 section
    var lastSection: Int? {
        return numberOfSections > 0 ? numberOfSections - 1 : nil
    }
    
    /// tableview 最后一个 section 的最后一个 row 的位置
    var indexPathForLastRow: IndexPath? {
        guard let lastSection = lastSection else {
            return nil
        }
        return indexPathForLastRow(at: lastSection)
    }
    
}

//==============================================================
//MARK: - Methods
//==============================================================

public extension UITableView {
    
    /// 检查 indexPath 是否有效
    ///
    /// - Parameter indexPath: 需要检查的 indexPath
    /// - Returns: 是否有效
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 && indexPath.row >= 0 && indexPath.section < numberOfSections && indexPath.row < numberOfRows(inSection: indexPath.section)
    }
    
    /// 获取所有 row 的数量
    ///
    /// - Returns: tableview 所有 row 的数量
    func numberOfRows() -> Int {
        var section = 0
        var rowNumber = 0
        while section < numberOfSections {
            rowNumber += numberOfRows(inSection: section)
            section += 1
        }
        return rowNumber
    }
    
    /// 获取 section 的最后一个 row 的位置
    ///
    /// - Parameter section: 最后一个 section
    /// - Returns: row 的位置，nil 该 section 不存在或没有 row
    func indexPathForLastRow(at section: Int) -> IndexPath? {
        guard numberOfSections > 0, section >= 0, numberOfRows(inSection: section) > 0 else { return nil }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    /// 刷新 tableview
    ///
    /// - Parameter complete: 刷新完成回调
    func reloadData(_ complete:@escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { (_) in
            complete()
        }
    }
    
    /// 安全滑动到 indexPath 对应的 row
    ///
    /// - Parameters:
    ///   - indexPath: indexPath
    ///   - scrollPosition: 滑动位置
    ///   - animated: 是否动画
    func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition = .none, animated: Bool = true) {
        guard indexPath.section < numberOfSections else { return }
        guard indexPath.row < numberOfRows(inSection: indexPath.section) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    /// 从重用池获取 cell
    ///
    /// - Parameters:
    ///   - name: cell 类型
    ///   - identifier: 重用ID，nil 以 name 类型字符串作为ID
    /// - Returns: name 对应类型的 cell
    func dequeueReusableCell<T: UITableViewCell>(class name: T.Type, identifier: String? = nil) -> T {
        let reuseIdentifier = identifier ?? String(describing: name)
        guard let cell = dequeueReusableCell(withIdentifier: reuseIdentifier) as? T else {
            fatalError("无法取得重用标识符为：\(reuseIdentifier) 的 Cell，请确定是否已正确注册该类型 Cell！")
        }
        return cell
    }
    
    /// 从重用池获取 cell
    ///
    /// - Parameters:
    ///   - name: cell 类型
    ///   - identifier: 重用ID，nil 以 name 类型字符串作为ID
    ///   - indexPath: indexPath
    /// - Returns: name 对应类型的 cell
    func dequeueReusableCell<T: UITableViewCell>(class name: T.Type, identifier: String? = nil, for indexPath: IndexPath) -> T {
        let reuseIdentifier = identifier ?? String(describing: name)
        guard let cell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T else {
            fatalError("无法取得重用标识符为：\(reuseIdentifier) 的 Cell，请确定是否已正确注册该类型 Cell！")
        }
        return cell
    }
    
    /// 从重用池获取 headerFooterView
    ///
    /// - Parameters:
    ///   - name: headerFooterView 的类型
    ///   - identifier: 重用ID，nil 以 name 类型字符串作为ID
    /// - Returns: name 对应类型的 headerFooterView
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(class name: T.Type, identifier: String? = nil) -> T {
        let reuseIdentifier = identifier ?? String(describing: name)
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? T else {
            fatalError("无法取得重用标识符为：\(reuseIdentifier) 的 HeaderFooterView，请确定是否已正确注册该类型 HeaderFooterView！")
        }
        return headerFooterView
    }
    
    /// 注册重用 cell，重用标识符为 name 类型字符串
    ///
    /// - Parameter name: cell 的类型，不传为 UITableViewCell
    func registerReusableCell<T: UITableViewCell>(class name: T.Type? = nil) {
        let cellClass = name ?? UITableViewCell.self
        let reuseIdentifier = String(describing: cellClass)
        register(name, forCellReuseIdentifier: reuseIdentifier)
    }
    
    /// 注册重用 cell，重用标识符为 name 类型字符串
    ///
    /// - Parameters:
    ///   - nib: nib
    ///   - name: cell 的类型，不传为 UITableViewCell
    func registerReusableCell<T: UITableViewCell>(nib: UINib?, class name: T.Type? = nil) {
        let cellClass = name ?? UITableViewCell.self
        let reuseIdentifier = String(describing: cellClass)
        register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    /// 注册重用 HeaderFooterView，重用标识符为 name 类型字符串
    ///
    /// - Parameter name: HeaderFooterView 的类型，不传为 UITableViewHeaderFooterView
    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(class name: T.Type? = nil) {
        let cellClass = name ?? UITableViewHeaderFooterView.self
        let reuseIdentifier = String(describing: cellClass)
        register(name, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    /// 注册重用 HeaderFooterView，重用标识符为 name 类型字符串
    ///
    /// - Parameters:
    ///   - nib: nib
    ///   - name: HeaderFooterView 的类型，不传为 UITableViewHeaderFooterView
    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(nib: UINib?, class name: T.Type? = nil) {
        let cellClass = name ?? UITableViewHeaderFooterView.self
        let reuseIdentifier = String(describing: cellClass)
        register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
}
