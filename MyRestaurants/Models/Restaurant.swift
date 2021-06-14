//
//  Restaurant.swift
//  MyRestaurants
//
//  Created by Dylan Park on 2021-06-01.
//

import Foundation
import UIKit

struct Restaurant: Hashable {
  var title: String
  var price: Price
  var image: UIImage?
  var types: [Type]
  
  enum Price: String {
      case cheap = "$"
      case expensive = "$$"
  }
  
  static let restaurants: [Restaurant] = [
      Restaurant(title: "Jollibee", price: .cheap, image: UIImage(named: "jollibee"), types: [.fastfood]),
      Restaurant(title: "Goldilocks", price: .cheap, image: UIImage(named: "goldilocks"), types: [.fastfood, .cakes]),
      Restaurant(title: "Good Taste", price: .cheap, image: UIImage(named: "good taste"), types: [.seafood, .cakes, .lunch]),
      Restaurant(title: "Mary Grace", price: .expensive, image: UIImage(named: "mary grace"), types: [.cakes, .lunch, .breakfast]),
      Restaurant(title: "Barrio Fiesta", price: .expensive, image: UIImage(named: "barrio fiesta"), types: [.lunch]),
      Restaurant(title: "Sambokojin", price: .expensive, image: UIImage(named: "sambokojin"), types: [.buffet, .seafood]),
      Restaurant(title: "Vikings", price: .expensive, image: UIImage(named: "vikings"), types: [.buffet, .seafood]),
      Restaurant(title: "Cabalen", price: .cheap, image: UIImage(named: "cabalen"), types: [.buffet, .lunch]),
      Restaurant(title: "Mesa", price: .expensive, image: UIImage(named: "mesa"), types: [.breakfast, .lunch]),
      Restaurant(title: "Kuya J", price: .expensive, image: UIImage(named: "kuya j"), types: [.lunch]),
      Restaurant(title: "Mang Inasal", price: .cheap, image: UIImage(named: "mang inasal"), types: [.fastfood, .breakfast]),
      Restaurant(title: "Chowking", price: .cheap, image: UIImage(named: "chowking"), types: [.fastfood, .chinese])
  ]
}
