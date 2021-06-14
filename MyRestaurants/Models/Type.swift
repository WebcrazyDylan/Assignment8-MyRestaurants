//
//  Type.swift
//  MyRestaurants
//
//  Created by Dylan Park on 2021-06-01.
//

import Foundation

enum Type: String, CaseIterable, Hashable {
  case breakfast, lunch, buffet, fastfood, seafood, chinese, cakes
  
  static var selectedTypes = [Type: Bool]()
}
