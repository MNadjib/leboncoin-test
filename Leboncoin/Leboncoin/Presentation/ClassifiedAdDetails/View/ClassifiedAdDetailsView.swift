//
//  ClassifiedAdDetailsView.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 19/07/2021.
//

import UIKit

class ClassifiedAdDetailsView: UIView {
    
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
        setupScrollView()
        setupTitleLabel()
        setupUrgentIcon()
        setupUrgentLabel()
        setupImageView()
        setupDateLabel()
        setupPriceLabel()
        setupCategoryLabel()
        setupDescriptionTextView()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:-8.0).isActive = true
    }
    
    private func setupUrgentIcon() {
        contentView.addSubview(urgentIcon)
        urgentIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        urgentIcon.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 8.0).isActive = true
        urgentIcon.widthAnchor.constraint(equalToConstant: 18).isActive = true
        urgentIcon.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    private func setupUrgentLabel() {
        contentView.addSubview(urgentLabel)
        urgentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        urgentLabel.leadingAnchor.constraint(equalTo:urgentIcon.trailingAnchor, constant: 8.0).isActive = true
        urgentLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -8.0).isActive = true
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: urgentLabel.bottomAnchor, constant: 8.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:-8.0).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8.0).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 8.0).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    private func setupPriceLabel() {
        contentView.addSubview(priceLabel)
        priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8.0).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo:dateLabel.leadingAnchor, constant: 8.0).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -8.0).isActive = true
    }
    
    private func setupCategoryLabel() {
        contentView.addSubview(categoryLabel)
        categoryLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8.0).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 8.0).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -8.0).isActive = true
    }
    
    private func setupDescriptionTextView() {
        contentView.addSubview(descirptionTextView)
        descirptionTextView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8.0).isActive = true
        descirptionTextView.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 8.0).isActive = true
        descirptionTextView.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -8.0).isActive = true
        descirptionTextView.bottomAnchor.constraint(equalTo:contentView.bottomAnchor, constant: -8.0).isActive = true
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    let contentView : UIView = {

        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.backgroundColor = UIColor.white
        return content
    }()
    
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
        label.font = .systemFont(ofSize: 12)
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
        textView.text = "description"
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 0.2
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let color: UIColor = .gray
        textView.layer.borderColor = color.cgColor
        textView.sizeToFit()
        textView.isScrollEnabled = false
        return textView
    }()
}
