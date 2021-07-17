//
//  ClassifiedAdsRepository.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 17/07/2021.
//

import UIKit

class ClassifiedAdsRepository {
    
    typealias Completion = ( Swift.Result<[ClassifiedAd], Error>) -> Void
    
    private let provider: NetworkProvider
    
    init(_ provider: NetworkProvider) {
        self.provider = provider
    }
}

extension ClassifiedAdsRepository: PClassifiedAdsRepository {
    @discardableResult
    func retrieveClassifiedAds(_ completion: @escaping Completion) -> Cancellable {
        return provider.request(.classifiedAds) { result in
            switch result {
            case .success(let data):
                do {
                    if let data = data {
                        let response = try JSONDecoder().decode([ClassifiedAdMapping].self, from: data)
                    }
                } catch let error{
                    completion(.failure(.defaultError))
                }
        
            case .failure(let error):
                completion(.failure(.defaultError))
            }
        }
    }
}


