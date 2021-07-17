//
//  PCategoriesRepository.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 17/07/2021.
//

import UIKit

protocol PCategoriesRepository {
    typealias Completion = ( Swift.Result<[Category], Error>) -> Void
    
    @discardableResult
    func retrieveCategories(_ completion: @escaping Completion) -> Cancellable
}
