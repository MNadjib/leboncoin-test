//
//  ImagesURLMapping.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 16/07/2021.
//

import UIKit

struct ImagesURLMapping: Decodable {
    var small: String?
    var thumb: String?
    
    func toModel() -> ImageUrl {
        ImageUrl(small: small, thumb: thumb)
    }
}
