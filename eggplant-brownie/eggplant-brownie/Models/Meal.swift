//
//  Meal.swift
//  eggplant-brownie
//
//  Created by Naiara de Almeida Pantuza on 09/05/23.
//

import UIKit

class Meal: NSObject {
  
  //MARK: - Attributes
  
  let name: String?
  let satisfaction: Int?
  var items = Array<Item>()
  
  //MARK: - Init
  
  init(name: String, satisfaction: Int, items: [Item] = []) {
    self.name = name
    self.satisfaction = satisfaction
    self.items = items
  }
  
  //MARK: - Methods
  
  func allCalories() -> Double {
    var total = 0.0
    for item in items {
      total += item.calories!
    }
    return total
  }
  
  func details() -> String {
    var message = "Satisfaction: \(satisfaction ?? 0)\n\nIngredients:\n"
    
    for item in items {
      message += "- \(item.name ?? "") - \(item.calories ?? 0) calories\n"
    }
    
    return message
    
  }
  
}
