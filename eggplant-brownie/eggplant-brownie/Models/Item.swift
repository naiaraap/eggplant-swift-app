//
//  Item.swift
//  eggplant-brownie
//
//  Created by Naiara de Almeida Pantuza on 09/05/23.
//

import UIKit

class Item: NSObject {
  let name: String?
  let calories: Double?
  
  init(name: String, calories: Double) {
    self.name = name
    self.calories = calories
  }
}
