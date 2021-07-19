//
//  ReusableView.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 18/07/2021.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

