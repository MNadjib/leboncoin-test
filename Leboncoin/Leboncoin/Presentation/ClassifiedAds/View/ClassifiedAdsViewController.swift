//
//  ClassifiedAdsViewController.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 15/07/2021.
//

import UIKit


class ClassifiedAdsViewController: UIViewController,AlertController {
    
    var viewModel: ClassifiedAdsViewModelInput
    
    private var searchController = UISearchController()
    
    
    init(with viewModel: ClassifiedAdsViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        super.loadView()
        setupView()
        setupSearchController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.title = localize("ads")
    }
    
    private func setupView() {
        let classifiedAdsView = ClassifiedAdsView()
        classifiedAdsView.tableViewDataSourceDelegate = self
        view = classifiedAdsView
    }
    
    private func loadData () {
        viewModel.retrieveData { [weak self] in
            (self?.view as! ClassifiedAdsView).reloadData()
            self?.searchController.searchBar.scopeButtonTitles = AdStatus.allCases.map({ localize($0.rawValue)})
        } error: {[weak self] error in
            self?.showAlert(message: error)
        }
    }
    
    private func setupSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = localize("search")
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
    
}

extension ClassifiedAdsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: ClassifiedAdTableViewCell = tableView.dequeueReusableCell(for: indexPath) {
            cell.item = viewModel.item(for: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectRow(indexPath)
    }
}

extension ClassifiedAdsViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let status = AdStatus.allCases[searchBar.selectedScopeButtonIndex]
        let query = searchBar.text
        viewModel.filterAds(status, query)
        (view as! ClassifiedAdsView).reloadData()
    }
}
