//
//  ClassifiedAdsViewModel.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 15/07/2021.
//

import UIKit



protocol ClassifiedAdsViewModelInput: class {
    func retrieveData(success successCallback: @escaping (() -> Void),
                      error errorCallback: @escaping ((String) -> Void))
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(in section: Int) -> Int
    func item(for indexPath: IndexPath) -> ClassifiedAdViewModel
    func categoriesTitle() -> [String]
    func filterAds(_ status: AdStatus, _ query: String?)
    func selectRow(_ index: IndexPath)
    func selectCategories(callback: @escaping (() -> Void))
}

class ClassifiedAdsViewModel {
    
    private var useCase: ClassifiedAdsUseCases?
    private var items: [ClassifiedAdViewModel] = []
    private var filtredItems: [ClassifiedAdViewModel] = []
    private var categories:[Category] = []
    private var searchQuery = SearchQuery()
    private var coordinator:ClassifiedAdsCoordinatorInput?
    
    init(_ useCase: ClassifiedAdsUseCases, coordinator: ClassifiedAdsCoordinatorInput) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}

extension ClassifiedAdsViewModel: ClassifiedAdsViewModelInput {
    
    func retrieveData(success successCallback: @escaping (() -> Void), error errorCallback: @escaping ((String) -> Void)) {
        useCase?.retrieveData({ [weak self] result in
            switch result {
            case .success(let data):
                self?.categories = data.1
                self?.items = data.0.map({ ad -> ClassifiedAdViewModel in
                    ad.toViewModel()
                })
                self?.items.sort(by: { ClassifiedAdViewModel.sorter($0, $1)})
                self?.filtredItems = self?.items ?? []
                successCallback()
            case .failure(let error):
                errorCallback(error.localizedDescription)
            }
        })
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(in section: Int) -> Int {
        return filtredItems.count
    }
    
    func item(for indexPath: IndexPath) -> ClassifiedAdViewModel {
        filtredItems[indexPath.row]
    }
    
    func categoriesTitle() -> [String] {
        return categories.map({$0.name})
    }
    
    func filterAds(_ status: AdStatus, _ query: String?) {
        searchQuery.adStatus = status
        searchQuery.query = query ?? ""
        filtredItems = items.filter { ad -> Bool in
            searchQuery.match(ad)
        }
    }
    
    func selectRow(_ index: IndexPath) {
        let item = filtredItems[index.row]
        coordinator?.presentClassifiedAdDetails(item)
    }
    
    func selectCategories(callback:@escaping (() -> Void)) {
        coordinator?.presentCategories(categories, searchQuery.categories, { [unowned self] cats in
            self.searchQuery.categories = cats
            self.filtredItems = self.items.filter { ad -> Bool in
                self.searchQuery.match(ad)
            }
            callback()
        })
    }
}
