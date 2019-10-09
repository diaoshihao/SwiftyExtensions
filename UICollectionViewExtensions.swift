//
//  UICollectionViewExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/26.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

//==============================================================
//MARK: - Enum
//==============================================================
public extension UICollectionView {
    enum ReusableViewKind {
        case header
        case footer
        
        var string: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            }
        }
        
    }
}

//==============================================================
//MARK: - Properties
//==============================================================

public extension UICollectionView {
    
    /// collection view 最后一个 section
    var lastSection: Int? {
        return numberOfSections > 0 ? numberOfSections - 1 : nil
    }
    
    /// collection view 最后一个 section 的最后一个 item 的位置
    var indexPathForLastItem: IndexPath? {
        guard let lastSection = lastSection else {
            return nil
        }
        return indexPathForLastItem(at: lastSection)
    }
    
}

//==============================================================
//MARK: - Methods
//==============================================================

public extension UICollectionView {
    
    /// 检查 indexPath 是否有效
    ///
    /// - Parameter indexPath: 需要检查的 indexPath
    /// - Returns: 是否有效
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 && indexPath.item >= 0 && indexPath.section < numberOfSections && indexPath.item < numberOfItems(inSection: indexPath.section)
    }
    
    /// 获取所有 item 的数量
    ///
    /// - Returns: collection view 所有 item 的数量
    func numberOfItems() -> Int {
        var section = 0
        var itemNumber = 0
        while section < numberOfSections {
            itemNumber += numberOfItems(inSection: section)
            section += 1
        }
        return itemNumber
    }
    
    /// 获取 section 的最后一个 item 的位置
    ///
    /// - Parameter section: 最后一个 section
    /// - Returns: item 的位置，nil 该 section 不存在或没有 item
    func indexPathForLastItem(at section: Int) -> IndexPath? {
        guard numberOfSections > 0, section >= 0, numberOfItems(inSection: section) > 0 else { return nil }
        return IndexPath(item: numberOfItems(inSection: section) - 1, section: section)
    }
    
    /// 刷新 collection view
    ///
    /// - Parameter complete: 刷新完成回调
    func reloadData(_ complete:@escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { (_) in
            complete()
        }
    }
    
    /// 安全滑动到 indexPath 对应的 item
    ///
    /// - Parameters:
    ///   - indexPath: indexPath
    ///   - scrollPosition: 滑动位置
    ///   - animated: 是否动画
    func safeScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition = [], animated: Bool = true) {
        guard indexPath.section < numberOfSections else { return }
        guard indexPath.item < numberOfItems(inSection: indexPath.section) else { return }
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    /// 从重用池获取 cell
    ///
    /// - Parameters:
    ///   - name: cell 类型
    ///   - identifier: 重用ID，nil 以 name 类型字符串作为ID
    ///   - indexPath: indexPath
    /// - Returns: name 对应类型的 cell
    func dequeueReusableCell<T: UICollectionViewCell>(class name: T.Type, identifier: String? = nil, for indexPath: IndexPath) -> T {
        let reuseIdentifier = identifier ?? String(describing: name)
        guard let cell = dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T else {
            fatalError("无法取得重用标识符为：\(reuseIdentifier) 的 Cell，请确定是否已正确注册该类型 Cell！")
        }
        return cell
    }
    
    /// 从重用池获取 ReusableView
    ///
    /// - Parameters:
    ///   - name: ReusableView 的类型
    ///   - kind: ReusableView 的种类（header/footer）
    ///   - identifier: 重用ID，nil 以 name 类型字符串作为ID
    /// - Returns: name 对应类型的 ReusableView
    func dequeueReusableView<T: UICollectionReusableView>(class name: T.Type, kind: ReusableViewKind, identifier: String? = nil, for indexPath: IndexPath) -> T {
        let reuseIdentifier = identifier ?? String(describing: name)
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: kind.string, withReuseIdentifier: reuseIdentifier, for: indexPath) as? T else {
            fatalError("无法取得重用标识符为：\(reuseIdentifier) 的 ReusableView，请确定是否已正确注册该类型 ReusableView！")
        }
        return reusableView
    }
    
    /// 注册重用 cell，重用标识符为 name 类型字符串
    ///
    /// - Parameter name: cell 的类型，不传为 UICollectionViewCell
    func registerReusableCell<T: UICollectionViewCell>(class name: T.Type? = nil) {
        let cellClass = name ?? UICollectionViewCell.self
        let reuseIdentifier = String(describing: cellClass)
        register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    /// 注册重用 cell，重用标识符为 name 类型字符串
    ///
    /// - Parameters:
    ///   - nib: nib
    ///   - name: cell 的类型，不传为 UICollectionViewCell
    func registerReusableCell<T: UICollectionViewCell>(nib: UINib?, class name: T.Type? = nil) {
        let cellClass = name ?? UICollectionViewCell.self
        let reuseIdentifier = String(describing: cellClass)
        register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    /// 注册重用 SupplementaryView，重用标识符为 name 类型字符串
    ///
    /// - Parameter
    ///   - name: SupplementaryView 的类型，不传为 UICollectionReusableView
    ///   - kind: ReusableView 的种类（header/footer）
    func registerSupplementaryView<T: UICollectionReusableView>(class name: T.Type? = nil, kind: ReusableViewKind) {
        let viewClass = name ?? UICollectionReusableView.self
        let reuseIdentifier = String(describing: viewClass)
        register(viewClass, forSupplementaryViewOfKind: kind.string, withReuseIdentifier: reuseIdentifier)
    }
    
    /// 注册重用 SupplementaryView，重用标识符为 name 类型字符串
    ///
    /// - Parameters:
    ///   - nib: nib
    ///   - name: SupplementaryView 的类型，不传为 UICollectionReusableView
    ///   - kind: ReusableView 的种类（header/footer）
    func registerSupplementaryView<T: UICollectionReusableView>(nib:UINib?, class name: T.Type? = nil, kind: ReusableViewKind) {
        let viewClass = name ?? UICollectionReusableView.self
        let reuseIdentifier = String(describing: viewClass)
        register(nib, forSupplementaryViewOfKind: kind.string, withReuseIdentifier: reuseIdentifier)
    }
}

