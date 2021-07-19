//
//  PCategoriesRepository.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 17/07/2021.
//

import UIKit

protocol PCategoriesRepository {

    typealias Completion = (Result<[Category], Error>) -> Void
    @discardableResult
    func retrieveData(_ completion: @escaping Completion) -> Cancellable?
}
