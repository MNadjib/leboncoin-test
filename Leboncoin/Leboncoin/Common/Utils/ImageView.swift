//
//  ImageView.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 18/07/2021.
//

import UIKit

class ImageView: UIImageView {
    var placeholder: UIImage?
    var error: UIImage?
    
    private let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    private static let cache = NSCache<NSString, NSData>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupActivityIndicatorView()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupActivityIndicatorView() {
        activityIndicatorView.hidesWhenStopped = true
        self.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: .zero).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: .zero).isActive = true
    }
    
    
    func download(from url: String?) {
        guard let url = url else {
            image = placeholder
            return
        }
        
        activityIndicatorView.startAnimating()
        let provider = NetworkProvider()
        if let data = ImageView.cache.object(forKey: url as NSString) {
            image = UIImage(data: data as Data)
            activityIndicatorView.stopAnimating()
        } else {
            provider.request(.image(urlString: url), { [weak self] (result) in
                switch result {
                case .success(let data):
                    if let data = data {
                        ImageView.cache.setObject(data as NSData, forKey: url as NSString)
                        self?.image = UIImage(data: data) ?? self?.placeholder
                    }
                case .failure( let error):
                    if error == .noNetwork {
                        self?.image = self?.placeholder
                    } else {
                        self?.image = self?.error
                    }
                }
                self?.activityIndicatorView.stopAnimating()
            })
        }
    }
}
