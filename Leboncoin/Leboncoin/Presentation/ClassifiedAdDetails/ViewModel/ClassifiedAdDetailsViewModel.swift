//
//  ClassifiedAdDetailsViewModel.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 19/07/2021.
//

import UIKit

protocol ClassifiedAdDetailsViewModelInput: class {
    var classifiedAdItem: ClassifiedAdViewModel {get}
}

class ClassifiedAdDetailsViewModel {
    var classifiedAdViewModel: ClassifiedAdViewModel
    
    init(_ model: ClassifiedAdViewModel) {
        classifiedAdViewModel = model
    }
}

extension ClassifiedAdDetailsViewModel: ClassifiedAdDetailsViewModelInput {
    var classifiedAdItem: ClassifiedAdViewModel {
        return classifiedAdViewModel
    }
}
