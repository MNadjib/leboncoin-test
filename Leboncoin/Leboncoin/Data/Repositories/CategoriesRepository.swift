//
//  CategoriesRepositories.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 17/07/2021.
//

import UIKit

class CategoriesRepository {
    typealias Completion = (Result<[Category], Error>) -> Void
    private let provider: NetworkProviderInput
    
    init(_ provider: NetworkProviderInput) {
        self.provider = provider
    }
}

extension CategoriesRepository: PCategoriesRepository {
    @discardableResult
    func retrieveData(_ completion: @escaping Completion) -> Cancellable? {
        return provider.request(.categories) { result in
            switch result {
            case .success(let data):
                do {
                    if let data = data  {
                        let catsMapping = try JSONDecoder().decode([CategoryMapping].self, from: data)
                        let categories = catsMapping.map { catMapping -> Category in
                            catMapping.toModel()
                        }
                        log(categories)
                        completion(.success(categories))
                    }
                } catch let error{
                    log(error.localizedDescription)
                    completion(.failure(.jsonDecodingError(error.localizedDescription)))
                }
        
            case .failure(let error):
                log(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
