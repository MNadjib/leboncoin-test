//
//  ClassifiedAdsCoordinator.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 15/07/2021.
//

import UIKit

protocol ClassifiedAdsCoordinatorInput: class {
    func presentClassifiedAdDetails(_ model: ClassifiedAdViewModel)
    func presentCategories(_ categories: [Category], _ selectedCategories: Set<Category>, _ completion: @escaping ((Set<Category>) -> Void))
}

class ClassifiedAdsCoordinator {
    
    var navigationController: UINavigationController
    var viewController: ClassifiedAdsViewController?
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupDependencies()
    }
    
    private func setupDependencies() {
        let provider = NetworkProvider()
        let classifiedAdsRepository = ClassifiedAdsRepository(provider)
        let categoryRepository = CategoriesRepository(provider)
        let useCase = RetrieveClassifiedAdsUseCases(classifiedAdsRepository, categoryRepository)
        let viewModel = ClassifiedAdsViewModel(useCase, coordinator: self)
        viewController = ClassifiedAdsViewController(with: viewModel)
    }
    
    func start() {
        navigationController.viewControllers = [viewController!]
    }
}

extension ClassifiedAdsCoordinator: ClassifiedAdsCoordinatorInput {
    func presentCategories(_ categories: [Category], _ selectedCategories: Set<Category>, _ completion: @escaping ((Set<Category>) -> Void)) {
        let coordinator =  CategoriesCoordinator(categories, selectedCategories, completion)
        let nav =  UINavigationController(rootViewController: coordinator.viewController!)
        viewController?.present(nav, animated: true, completion: nil)
    }
    
    func presentClassifiedAdDetails(_ model: ClassifiedAdViewModel) {
        let coordinator =  ClassifiedAdDetailsCoordinator(model)
        viewController?.navigationController?.pushViewController(coordinator.viewController!, animated: true)
    }
}
