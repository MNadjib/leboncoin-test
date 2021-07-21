//
//  CategoriesViewModel.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 20/07/2021.
//

import UIKit

protocol CategoriesViewModelInput: class {
    func numberOfSections() -> Int
    func numberOfRowsInSection(in section: Int) -> Int
    func item(for indexPath: IndexPath) -> String
    func itemSelected(for indexPath: IndexPath) -> Bool
    func selectRow(for indexPath: IndexPath) -> Bool
    func validate()
    func cancel()
}

class CategoriesViewModel {
    var categories: [Category]
    var selectedCategories: Set<Category>
    var completion: ((Set<Category>) -> Void)
    var coordinator: CategoriesCoordinatorInput
    
    init(_ coordinator: CategoriesCoordinatorInput,  _ categories: [Category], _ selectedCategories: Set<Category>, _ completion: @escaping ((Set<Category>) -> Void)) {
        self.coordinator = coordinator
        self.categories = categories
        self.selectedCategories = selectedCategories
        self.completion = completion
    }
}

extension CategoriesViewModel: CategoriesViewModelInput {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(in section: Int) -> Int {
        return categories.count
    }
    
    func item(for indexPath: IndexPath) -> String {
        return categories[indexPath.row].name
    }
    
    func itemSelected(for indexPath: IndexPath) -> Bool {
        let category = categories[indexPath.row]
        return selectedCategories.filter { selCat -> Bool in
            category.id == selCat.id
        }.count == 1
    }
    
    func selectRow(for indexPath: IndexPath) -> Bool {
        let category = categories[indexPath.row]
        let selected =  selectedCategories.filter { selCat -> Bool in
            category.id == selCat.id
        }.count == 1
        
        if selected {
            selectedCategories.remove(category)
            return false
        } else {
            selectedCategories.insert(category)
            return true
        }
    }
    
    func validate() {
        completion(selectedCategories)
        coordinator.dismiss()
    }
    
    func cancel() {
        coordinator.dismiss()
    }
}
