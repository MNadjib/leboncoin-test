//
//  LoadingView.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 20/07/2021.
//

import UIKit

class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLoadingText(_ text: String)  {
        label.text = text
    }
    
    private func setupView() {
        let color: UIColor = .black
        backgroundColor = color.withAlphaComponent(0.3)
        setupLoadingView()
        setupActivityIndicator()
        setupLabel()
    }
    
    private func setupLoadingView() {
        addSubview(loadView)
        loadView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        loadView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        loadView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        loadView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    private func setupActivityIndicator() {
        loadView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: loadView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: loadView.centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: .zero).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: .zero).isActive = true
    }
    
    private func setupLabel() {
        loadView.addSubview(label)
        label.topAnchor.constraint(equalTo: activityIndicatorView.topAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: loadView.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: loadView.trailingAnchor, constant: -10).isActive = true
        label.bottomAnchor.constraint(equalTo: loadView.bottomAnchor, constant: -10).isActive = true
    }
    
    var loadView: UIView = {
        let loadView = UIView(frame: .zero)
        loadView.translatesAutoresizingMaskIntoConstraints = false
        loadView.backgroundColor = .darkGray
        loadView.layer.cornerRadius = 8
        loadView.layer.borderWidth = 0.2
        loadView.layer.borderColor = UIColor.white.cgColor
        return loadView
    }()
    
    var label: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.text = "message"
        return label
    }()
    
    let activityIndicatorView =  UIActivityIndicatorView(style:.whiteLarge)
}


class LoadingView {
    var view : CustomView
    
    init(with message: String) {
        view = CustomView(frame: .zero)
        view.updateLoadingText(message)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func show() {
        if let parent = topMostViewController?.view {
            parent.addSubview(view)
            view.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor).isActive = true
            view.layoutSubviews()
        }
    }
    
    func hide() {
        self.view.removeFromSuperview()
    }
    
    var topMostViewController: UIViewController? {
        var presentedVC = UIApplication.shared.keyWindow?.rootViewController
        while let controller = presentedVC?.presentedViewController {
            presentedVC = controller
        }
        return presentedVC
    }
}
