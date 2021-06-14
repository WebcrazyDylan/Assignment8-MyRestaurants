//
//  RestaurantCollectionViewCell.swift
//  My Restaurants
//
//  Created by Dylan Park on 2021-06-01.
//

import UIKit

protocol FiltersCollectionViewCellDelegate: AnyObject {
  func filterSelected()
}

class FiltersCollectionViewCell: UICollectionViewCell {

  static let identifier = "filterCell"
  weak var delegate: FiltersCollectionViewCellDelegate?
  
  var button: HighlightedButton = {
    let btn = HighlightedButton()
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitleColor(.black, for: .normal)
    btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
    btn.layer.cornerRadius = 4
    btn.layer.borderWidth = 1 / UIScreen.main.scale
    btn.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
    return btn
  }()
  
  @objc func buttonPressed(_ sender: UIButton) {
    UIView.animate(withDuration: 0.10) {
      sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    } completion: { (_) in
      UIView.animate(withDuration: 0.10) {
        sender.transform = .identity
      }
    }
    sender.isSelected.toggle()
    
    guard let text = sender.title(for: .normal), let type = Type(rawValue: text.lowercased()) else { return }
    if sender.isSelected { Type.selectedTypes[type] = true }
    else { Type.selectedTypes.removeValue(forKey: type) }
    
    delegate?.filterSelected()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(button)
    //constraints need to be applied so the button does not overflow outside the contentView
    button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
    button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
    button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
