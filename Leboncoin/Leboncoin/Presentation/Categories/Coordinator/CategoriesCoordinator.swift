//
//  CategoriesCoordinator.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 20/07/2021.
//

import UIKit

protocol CategoriesCoordinatorInput: class {
    func dismiss()
}

class CategoriesCoordinator {
    
    var viewController: CategoriesViewController?
    
    init(_ categories: [Category], _ selectedCategories: Set<Category>,_ completion: @escaping ((Set<Category>) -> Void)) {
        setupDependencies(categories, selectedCategories, completion)
    }
    
    private func setupDependencies(_ categories: [Category], _ selectedCategories: Set<Category>,_ completion: @escaping ((Set<Category>) -> Void)) {
        let viewModel = CategoriesViewModel(self, categories, selectedCategories, completion)
        viewController = CategoriesViewController(viewModel)
    }
}

extension CategoriesCoordinator: CategoriesCoordinatorInput {
    func dismiss() {
        viewController?.navigationController?.dismiss(animated: true, completion: nil)
    }
}
