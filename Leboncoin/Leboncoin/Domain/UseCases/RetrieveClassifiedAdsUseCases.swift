//
//  RetrieveClassifiedAdsUseCases.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 17/07/2021.
//

import UIKit


protocol ClassifiedAdsUseCases {
    typealias Completion = (Result<[ClassifiedAd], Error>) -> Void
    func retrieveData(_ completion: @escaping Completion) -> Cancellable
}

class RetrieveClassifiedAdsUseCases {
    typealias Completion = (Result<[ClassifiedAd], Error>) -> Void
    
    private let classifiedAdsRepository: PClassifiedAdsRepository
    private let categoriesRepository: PCategoriesRepository
    
    init(_ classifiedAdsRepository: PClassifiedAdsRepository, _ categoriesRepository: PCategoriesRepository) {
        self.classifiedAdsRepository = classifiedAdsRepository
        self.categoriesRepository = categoriesRepository
    }
}

extension RetrieveClassifiedAdsUseCases: ClassifiedAdsUseCases {
    func retrieveData(_ completion: @escaping Completion) -> Cancellable {
        return classifiedAdsRepository.retrieveClassifiedAds { result in
            
        }
    }
}
