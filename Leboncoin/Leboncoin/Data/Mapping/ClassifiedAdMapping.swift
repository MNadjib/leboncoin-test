//
//  ClassifiedAdRequestMapping.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 16/07/2021.
//

import UIKit

struct ClassifiedAdMapping: Decodable {
    var id: Int64
    var categoryId: Int64
    var creationDate: String
    var description: String
    var imagesUrl: ImagesURLMapping
    var isUrgent: Bool
    var price: Float
    var title: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case creationDate = "creation_date"
        case description
        case imagesUrl = "images_url"
        case isUrgent = "is_urgent"
        case price
        case title
    }
}
