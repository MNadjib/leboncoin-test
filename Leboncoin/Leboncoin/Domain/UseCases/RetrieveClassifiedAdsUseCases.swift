//
//  RetrieveClassifiedAdsUseCases.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 17/07/2021.
//

import UIKit


protocol ClassifiedAdsUseCases: class {
    typealias Completion = (Result<([ClassifiedAd], [Category]), Error>) -> Void
    func retrieveData(_ completion: @escaping Completion)
    func cancel()
}

class RetrieveClassifiedAdsUseCases {
    typealias Completion = (Result<([ClassifiedAd], [Category]), Error>) -> Void
    
    private let classifiedAdsRepository: PClassifiedAdsRepository
    private let categoriesRepository: PCategoriesRepository
    
    private var classifiedAdsCancellable: Cancellable?
    private var categoriesCancellable: Cancellable?
    
    init(_ classifiedAdsRepository: PClassifiedAdsRepository, _ categoriesRepository: PCategoriesRepository) {
        self.classifiedAdsRepository = classifiedAdsRepository
        self.categoriesRepository = categoriesRepository
    }
}

extension RetrieveClassifiedAdsUseCases: ClassifiedAdsUseCases {

    func retrieveData(_ completion: @escaping Completion) {
        
        let group = DispatchGroup()
        var classifiedAds: [ClassifiedAd] = []
        var categories: [Category] = []
        var errorAds: Error? = nil
        var errorCategories: Error? = nil
        
        group.enter()
        classifiedAdsCancellable = classifiedAdsRepository.retrieveData { result in
            switch result {
            case .success(let ads): classifiedAds = ads
            case .failure(let error): errorAds = error
            }
            group.leave()
        }
            
        group.enter()
        categoriesCancellable = categoriesRepository.retrieveData { result in
            switch result {
            case .success(let cat): categories = cat
            case .failure(let error): errorCategories = error
            }
            group.leave()
        }
            
        group.notify(queue: .main) {
            if let errorAds = errorAds {
                completion(.failure(errorAds))
            } else if let errorCategories =  errorCategories {
                completion(.failure(errorCategories))
            } else {
                let ads = classifiedAds.map { ad -> ClassifiedAd in
                    var ad = ad
                    if let name = categories.first(where: { $0.id == ad.categoryId})?.name {
                        ad.categoryName = name
                    }
                    return ad
                }
                completion(.success((ads, categories)))
            }
        }
    }
    
    func cancel() {
        classifiedAdsCancellable?.cancelRequest()
        categoriesCancellable?.cancelRequest()
    }
}
