//
//  CategoriesViewController.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 20/07/2021.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    var viewModel: CategoriesViewModelInput
    
    init(_ viewModel: CategoriesViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupView() {
        title = localize("categories")
        let categoriesView = CategoriesView()
        categoriesView.tableViewDataSourceDelegate = self
        view = categoriesView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: localize("cancel"), style: .plain, target: self, action: #selector(cancelTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: localize("validate"), style: .plain, target: self, action: #selector(validateTapped))
    }
    
    @objc private func validateTapped() {
        viewModel.validate()
    }
    
    @objc private func cancelTapped() {
        viewModel.cancel()
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.numberOfRowsInSection(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)!
        cell.textLabel?.text = viewModel.item(for: indexPath)
        cell.accessoryType = viewModel.itemSelected(for: indexPath) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = viewModel.selectRow(for: indexPath)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = selected ? .checkmark : .none
    }
}
