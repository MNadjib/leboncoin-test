//
//  ClassifiedAdTableViewCell.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 17/07/2021.
//

import UIKit

class ClassifiedAdTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Self.reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var item: ClassifiedAdViewModel? = nil  {
        didSet {
            adImageView.download(from: item?.imagesUrl.thumb)
            titleLabel.text = item?.title
            categoryLabel.text = item?.categoryName
            priceLabel.text = item?.priceString
            dateLabel.text = item?.creationDateString
            urgentIcon.isHidden = !(item?.isUrgent == true)
        }
    }
    
    private func setupView() {
        setupImageView()
        setupTitleLabel()
        setupUrgentIcon()
        setupCategoryLabel()
        setupDateLabel()
        setupPriceLabel()
    }
    
    private func setupImageView() {
        addSubview(adImageView)
        adImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        adImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0).isActive = true
        adImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        adImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: adImageView.trailingAnchor, constant: 8.0).isActive = true
    }
    
    private func setupCategoryLabel () {
        addSubview(categoryLabel)
        categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: adImageView.trailingAnchor, constant: 8.0).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0).isActive = true
    }
    
    private func setupUrgentIcon() {
        addSubview(urgentIcon)
        urgentIcon.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        urgentIcon.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8.0).isActive = true
        urgentIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0).isActive = true
        urgentIcon.widthAnchor.constraint(equalToConstant: 18).isActive = true
        urgentIcon.heightAnchor.constraint(equalToConstant:18).isActive = true
        
    }
    
    private func setupDateLabel () {
        addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8.0).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: adImageView.trailingAnchor, constant: 8.0).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant:80).isActive = true
    }
    
    private func setupPriceLabel () {
        addSubview(priceLabel)
        priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8.0).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 8.0).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0).isActive = true
    }
    
    private var adImageView: ImageView = {
        let  imageView = ImageView(frame: .zero)
        imageView.error = UIImage(named: "ImageError")
        imageView.placeholder = UIImage(named: "ImagePaceholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .black
        label.text = "title"
        return label
    }()
    
    private var categoryLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.text = "category"
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 11)
        label.textColor = .darkGray
        label.text = "20€"
        return label
    }()
    
    private var urgentIcon: UIImageView = {
        let  imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .red
        imageView.image = UIImage(named: "imageUrgent")
        return imageView
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 11)
        label.textColor = .darkGray
        label.text = "Date"
        return label
    }()
}
