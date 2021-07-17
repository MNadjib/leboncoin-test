//
//  PClassifiedAdsRepository.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 17/07/2021.
//

import UIKit

protocol PClassifiedAdsRepository {
    typealias Completion = (Result<[ClassifiedAd], Error>) -> Void
    
    @discardableResult
    func retrieveClassifiedAds(_ completion: @escaping Completion) -> Cancellable
}
