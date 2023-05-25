//
//  MealDao.swift
//  eggplant-brownie
//
//  Created by Naiara de Almeida Pantuza on 25/05/23.
//

import UIKit

class MealDao {
  func save(_ meals: [Meal]) {
    guard let path = retrieveMealsDirectory() else { return }
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
      try data.write(to: path)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  
  func retrieveMealsDirectory() -> URL? {
    guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
    let path = directory.appendingPathComponent("meals")
    
    return path
  }
  
  func getMealListFromFile() -> [Meal] {
    guard let path = retrieveMealsDirectory() else { return [] }
        do {
          let data = try Data(contentsOf: path)
          guard let storedMeals = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<Meal> else { return [] }
    
          var meals = storedMeals
          return meals
    
        } catch {
          print(error.localizedDescription)
          return []
        }
  }
  
}
