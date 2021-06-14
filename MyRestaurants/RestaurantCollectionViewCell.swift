//
//  RestaurantCollectionViewCell.swift
//  My Restaurants
//
//  Created by Dylan Park on 2021-06-01.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "restaurantCell"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let title: UILabel = {
        let lbl = UILabel()
        lbl.setContentHuggingPriority(.required, for: .horizontal)
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 1
        lbl.font = UIFont.init(name: "Arial", size: 19)
        return lbl
    }()
    let price: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 1
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        return lbl
    }()
    let classification: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.init(name: "Arial", size: 16)
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let hStackView = UIStackView(arrangedSubviews: [title, UIView(), price])
        hStackView.axis = .horizontal
        hStackView.alignment = .fill
        hStackView.distribution = .fill
        
        let vStackView = UIStackView(arrangedSubviews: [hStackView, classification])
        vStackView.axis = .vertical
        vStackView.alignment = .fill
        vStackView.distribution = .fill
        vStackView.spacing = 2
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        contentView.addSubview(vStackView)
        contentView.backgroundColor = .clear
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.65).isActive = true
        
        vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        vStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(with restaurant: Restaurant) {
        title.text = restaurant.title
        imageView.image = restaurant.image
        price.text = restaurant.price.rawValue
        classification.text = restaurant.types.map { $0.rawValue }.joined(separator: " ")
    }
}
