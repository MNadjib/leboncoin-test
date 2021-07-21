//
//  CategoriesView.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 20/07/2021.
//

import UIKit

class CategoriesView: UIView {
    var tableViewDataSourceDelegate:  (UITableViewDataSource & UITableViewDelegate)? = nil  {
        didSet {
            tableView.dataSource = tableViewDataSourceDelegate
            tableView.delegate = tableViewDataSourceDelegate
            tableView.reloadData()
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self)
        tableView.allowsSelection = true
        return tableView
    }()
}
