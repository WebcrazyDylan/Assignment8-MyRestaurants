//
//  UIButton+HighlightedButton.swift
//  MyRestaurants
//
//  Created by Dylan Park on 2021-06-01.
//

import Foundation
import UIKit

class HighlightedButton: UIButton {
  override var isSelected: Bool {
    didSet {
      backgroundColor = isSelected ? .systemBlue : .white
      setTitleColor(isSelected ? .white : .black, for: .normal)
    }
  }
}
