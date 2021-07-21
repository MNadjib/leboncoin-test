//
//  UITableView.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 18/07/2021.
//

import UIKit

extension UITableViewCell: ReusableView {}

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
    
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: T.reuseIdentifier)
    }
}

