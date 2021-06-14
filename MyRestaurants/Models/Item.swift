//
//  Item.swift
//  MyRestaurants
//
//  Created by Dylan Park on 2021-06-01.
//

import Foundation

enum Item: Hashable {
  case filter(Type)
  case restaurant(Restaurant)
}
