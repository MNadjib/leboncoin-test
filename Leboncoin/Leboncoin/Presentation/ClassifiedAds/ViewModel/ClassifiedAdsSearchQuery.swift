//
//  ClassifiedAdsSearchQuery.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 20/07/2021.
//

import UIKit

enum AdStatus: String, CaseIterable {
    case all
    case urgent
    case notUrgent
    
    func match(_ ad: ClassifiedAdViewModel) -> Bool {
        switch self {
        case .urgent: return ad.isUrgent
        case .notUrgent: return !ad.isUrgent
        default: return true
            
        }
    }
}

struct SearchQuery {
    var query: String = ""
    var adStatus: AdStatus = .all
    var categories: Set<Category> = Set()
    
    func match(_ ad: ClassifiedAdViewModel) -> Bool {
        adStatus.match(ad) &&
            (query.isEmpty ||
                ad.title.range(of: query, options: [.diacriticInsensitive, .caseInsensitive]) != nil ||
                ad.categoryName.range(of: query, options: [.diacriticInsensitive, .caseInsensitive]) != nil) &&
            (!categories.filter { cat  -> Bool in
                ad.categoryId == cat.id
            }.isEmpty || categories.isEmpty)
    }
}
