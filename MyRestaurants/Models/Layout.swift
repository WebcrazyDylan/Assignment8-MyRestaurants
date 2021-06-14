//
//  Layout.swift
//  MyRestaurants
//
//  Created by Dylan Park on 2021-06-01.
//

import Foundation

enum Layout: String {
  case grid
  case column
  
  mutating func toggle() {
    self = self == .grid ? .column : .grid
  }
}
