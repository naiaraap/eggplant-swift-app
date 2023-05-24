//
//  Item.swift
//  eggplant-brownie
//
//  Created by Naiara de Almeida Pantuza on 09/05/23.
//

import UIKit

class Item: NSObject, NSCoding {
  
  //MARK: - Attributes
  
  let name: String
  let calories: Double
  
  //MARK: - init
  
  init(name: String, calories: Double) {
    self.name = name
    self.calories = calories
  }
  
  //MARK: - NSCoding
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(calories, forKey: "calories")
  }
  
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as! String
    calories = aDecoder.decodeDouble(forKey: "calories")
  }
}
