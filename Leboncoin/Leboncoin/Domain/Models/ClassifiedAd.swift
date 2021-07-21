//
//  ClassifiedAd.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 17/07/2021.
//

import UIKit

struct ClassifiedAd {
    var id: Int64
    var categoryId: Int64
    var categoryName: String
    var creationDate: Date?
    var description: String
    var imagesUrl: ImageUrl
    var isUrgent: Bool
    var price: Float
    var title: String
    
    func toViewModel() -> ClassifiedAdViewModel{
        ClassifiedAdViewModel(id: id, categoryId: categoryId, categoryName: categoryName, creationDate: creationDate, description: description, imagesUrl: imagesUrl, isUrgent: isUrgent, price: price, title: title)
    }
}

struct ImageUrl {
    var small: String?
    var thumb: String?
}
