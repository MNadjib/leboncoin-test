//
//  ClassifiedAdsViewModel.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 15/07/2021.
//

import UIKit

enum AdStatus: String, CaseIterable {
    case all
    case urgent
    case notUrgent
    
    func match(_ ad: ClassifiedAdViewModel) -> Bool {
        switch self {
        case .urgent: return ad.isUrgent
        case .notUrgent: return !ad.isUrgent
        default: return true
            
        }
    }
}

protocol ClassifiedAdsViewModelInput: class {
    func retrieveData(success successCallback: @escaping (() -> Void),
                      error errorCallback: @escaping ((String) -> Void))
    
    func numberOfSections() -> Int
    func numberOfRowsInSection(in section: Int) -> Int
    func item(for indexPath: IndexPath) -> ClassifiedAdViewModel
    func categoriesTitle() -> [String]
    func filterAds(_ status: AdStatus, _ query: String?)
}

class ClassifiedAdsViewModel {
    
    private var useCase: ClassifiedAdsUseCases?
    private var items: [ClassifiedAdViewModel] = []
    private var filtredItems: [ClassifiedAdViewModel] = []
    private var categories:[Category] = []
    
    init( useCase: ClassifiedAdsUseCases) {
        self.useCase = useCase
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
        filtredItems = items.filter { ad -> Bool in
            let query = query ?? ""
            return status.match(ad) &&  (
                query.isEmpty ||
                    ad.title.range(of: query, options: [.diacriticInsensitive, .caseInsensitive]) != nil ||
                    ad.categoryName.range(of: query, options: [.diacriticInsensitive, .caseInsensitive]) != nil)
        }
    }
}
