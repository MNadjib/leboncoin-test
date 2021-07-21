//
//  ClassifiedAdViewModel.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 18/07/2021.
//

import UIKit

struct ClassifiedAdViewModel {
    var id: Int64
    var categoryId: Int64
    var categoryName: String
    var creationDate: Date?
    var description: String
    var imagesUrl: ImageUrl
    var isUrgent: Bool
    var price: Float
    var title: String
    
    var priceString: String {
        let unit = localize("euro")
        return String(format: "%.2f \(unit)", price)
    }
    
    var creationDateString: String {
        if let date = creationDate {
            return mediumDateFormatter.string(from: date)
        }
        return ""
    }
    
    var publishedDateString: String {
        if let date = creationDate {
            return "\(localize("published")) \(longDateFormatter.string(from: date))"
        }
        return ""
    }
}

extension ClassifiedAdViewModel {
    static func sorter(_ lhs: ClassifiedAdViewModel,_ rhs: ClassifiedAdViewModel) -> Bool{ 
        if lhs.isUrgent == rhs.isUrgent {
            if let lhsCreationDate = lhs.creationDate, let rhsCreationDate = rhs.creationDate {
                return lhsCreationDate > rhsCreationDate
            } else if let _ = lhs.creationDate {
                return false
            } else {
                return true
                
            }
        } else {
            return lhs.isUrgent
        }
    }
}

