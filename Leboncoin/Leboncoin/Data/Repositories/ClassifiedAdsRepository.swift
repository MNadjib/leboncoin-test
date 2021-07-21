//
//  ClassifiedAdsRepository.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 17/07/2021.
//

import UIKit

class ClassifiedAdsRepository {
    
    typealias Completion = ( Swift.Result<[ClassifiedAd], Error>) -> Void
    
    private let provider: NetworkProviderInput
    
    init(_ provider: NetworkProviderInput) {
        self.provider = provider
    }
}

extension ClassifiedAdsRepository: PClassifiedAdsRepository {
    @discardableResult
    func retrieveData(_ completion: @escaping Completion) -> Cancellable? {
        return provider.request(.classifiedAds) { result in
            switch result {
            case .success(let data):
                do {
                    if let data = data {
                        let adsMapping = try JSONDecoder().decode([ClassifiedAdMapping].self, from: data)
                        let ads = adsMapping.map { adMapping -> ClassifiedAd in
                            adMapping.toModel()
                        }
                        log(ads)
                        completion(.success(ads))
                    }
                } catch let error{
                    log(error.localizedDescription)
                    completion(.failure(.jsonDecodingError(error.localizedDescription)))
                }
        
            case .failure(let error):
                log(error.localizedDescription)
                completion(.failure(error) )
            }
        }
    }
}


