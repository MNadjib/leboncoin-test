//
//  CategoriesRepositories.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 17/07/2021.
//

import UIKit

class CategoriesRepositories {
    typealias Completion = ( Swift.Result<[Category], Error>) -> Void
    private let provider: NetworkProvider
    
    init(_ provider: NetworkProvider) {
        self.provider = provider
    }
}

extension CategoriesRepositories: PCategoriesRepository {
    @discardableResult
    func retrieveCategories(_ completion: @escaping Completion) -> Cancellable {
        return provider.request(.categories) { result in
            switch result {
            case .success(let data):
                do {
                    if let data = data {
                        let response = try JSONDecoder().decode([CategoryMapping].self, from: data)
                    }
                } catch let error{
                    completion(.failure(.defaultError))
                }
        
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
