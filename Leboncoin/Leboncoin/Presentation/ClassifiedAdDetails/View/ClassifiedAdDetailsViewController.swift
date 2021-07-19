//
//  ClassifiedAdDetailsViewController.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 19/07/2021.
//

import UIKit

class ClassifiedAdDetailsViewController: UIViewController {
    
    var viewModel: ClassifiedAdDetailsViewModelInput
    
    init(_ viewModel: ClassifiedAdDetailsViewModelInput) {
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
        (view as! ClassifiedAdDetailsView).item = viewModel.classifiedAdItem
    }
    
    private func setupView() {
        let classifiedAdDetailsView = ClassifiedAdDetailsView()
        view = classifiedAdDetailsView
    }
}
