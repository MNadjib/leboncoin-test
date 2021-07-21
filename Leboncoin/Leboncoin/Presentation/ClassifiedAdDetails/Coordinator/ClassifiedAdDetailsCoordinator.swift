//
//  ClassifiedAdDetailsCoordinator.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 19/07/2021.
//

import UIKit

class ClassifiedAdDetailsCoordinator {
    
    var viewController: ClassifiedAdDetailsViewController?
    
    init(_ classifiedAdModel: ClassifiedAdViewModel) {
        setupDependencies(classifiedAdModel)
    }
    
    private func setupDependencies(_ classifiedAdModel: ClassifiedAdViewModel) {
        let viewModel = ClassifiedAdDetailsViewModel(classifiedAdModel)
        viewController = ClassifiedAdDetailsViewController(viewModel)
    }
}
