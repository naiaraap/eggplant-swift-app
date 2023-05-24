//
//  Meal.swift
//  eggplant-brownie
//
//  Created by Naiara de Almeida Pantuza on 09/05/23.
//

import UIKit

class Meal: NSObject, NSCoding {
  
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
  
  //MARK: - NSCoding
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(satisfaction, forKey: "satisfaction")
    aCoder.encode(items, forKey: "items")
  }
  
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as? String
    satisfaction = aDecoder.decodeObject(forKey: "satisfaction") as? Int
    items = aDecoder.decodeObject(forKey: "items") as! Array<Item>
  }
  
  //MARK: - Methods
  
  func allCalories() -> Double {
    var total = 0.0
    for item in items {
      total += item.calories
    }
    return total
  }
  
  func details() -> String {
    var message = "Satisfaction: \(satisfaction ?? 0)\n\nIngredients:\n"
    
    for item in items {
      message += "- \(item.name) - \(item.calories) calories\n"
    }
    
    return message
    
  }
  
}
