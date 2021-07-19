//
//  ClassifiedAdDetailsView.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 19/07/2021.
//

import UIKit

class ClassifiedAdDetailsView: UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item: ClassifiedAdViewModel? = nil  {
        didSet {
            imageView.download(from: item?.imagesUrl.thumb)
            titleLabel.text = item?.title
            categoryLabel.text = item?.categoryName
            priceLabel.text = item?.priceString
            dateLabel.text = item?.publishedDateString
            descirptionTextView.text = item?.description
            urgentIcon.isHidden = !(item?.isUrgent == true)
            urgentLabel.isHidden = !(item?.isUrgent == true)
        }
    }
    
    private func setupView() {
        setupTitleLabel()
        setupUrgentIcon()
        setupUrgentLabel()
        setupImageView()
        setupDateLabel()
        setupPriceLabel()
        setupCategoryLabel()
        setupDescriptionTextView()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:safeAreaLayoutGuide.leadingAnchor, constant: 8.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:safeAreaLayoutGuide.trailingAnchor, constant: -8.0).isActive = true
    }
    
    private func setupUrgentIcon() {
        addSubview(urgentIcon)
        urgentIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        urgentIcon.leadingAnchor.constraint(equalTo:safeAreaLayoutGuide.leadingAnchor, constant: 8.0).isActive = true
        urgentIcon.widthAnchor.constraint(equalToConstant: 18).isActive = true
        urgentIcon.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    private func setupUrgentLabel() {
        addSubview(urgentLabel)
        urgentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        urgentLabel.leadingAnchor.constraint(equalTo:urgentIcon.trailingAnchor, constant: 8.0).isActive = true
        urgentLabel.trailingAnchor.constraint(equalTo:safeAreaLayoutGuide.trailingAnchor, constant: -8.0).isActive = true
    }
    
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: urgentLabel.bottomAnchor, constant: 8.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo:safeAreaLayoutGuide.leadingAnchor, constant: 8.0).isActive = true
        imageView.trailingAnchor.constraint(equalTo:safeAreaLayoutGuide.trailingAnchor, constant: -8.0).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8.0).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo:safeAreaLayoutGuide.leadingAnchor, constant: 8.0).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    private func setupPriceLabel() {
        addSubview(priceLabel)
        priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8.0).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo:dateLabel.leadingAnchor, constant: 8.0).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo:safeAreaLayoutGuide.trailingAnchor, constant: -8.0).isActive = true
    }
    
    private func setupCategoryLabel() {
        addSubview(categoryLabel)
        categoryLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8.0).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo:safeAreaLayoutGuide.leadingAnchor, constant: 8.0).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo:safeAreaLayoutGuide.trailingAnchor, constant: -8.0).isActive = true
    }
    
    private func setupDescriptionTextView() {
        addSubview(descirptionTextView)
        descirptionTextView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8.0).isActive = true
        descirptionTextView.leadingAnchor.constraint(equalTo:safeAreaLayoutGuide.leadingAnchor, constant: 8.0).isActive = true
        descirptionTextView.trailingAnchor.constraint(equalTo:safeAreaLayoutGuide.trailingAnchor, constant: -8.0).isActive = true
        
        descirptionTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8.0).isActive = true
        
    }
    
    private var titleLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.text = "title"
        return label
    }()
    
    private var imageView: ImageView = {
        let  imageView = ImageView(frame: .zero)
        imageView.error = UIImage(named: "ImageError")
        imageView.placeholder = UIImage(named: "ImagePaceholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var categoryLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.text = "category"
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 12)
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
    
    private var urgentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 11)
        label.textColor = .darkGray
        label.text = localize("ad_urgent")
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.text = "Date"
        return label
    }()
    
    private var descirptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 12)
        textView.textColor = .darkGray
        textView.showsVerticalScrollIndicator = true
        textView.text = "description"
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 0.2
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let color: UIColor = .darkGray
        textView.layer.borderColor = color.cgColor
        return textView
    }()
}
