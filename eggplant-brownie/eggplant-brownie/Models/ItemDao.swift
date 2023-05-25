//
//  ItemDao.swift
//  eggplant-brownie
//
//  Created by Naiara de Almeida Pantuza on 25/05/23.
//

import Foundation

class ItemDao {
  func save(_ itemsList: [Item]) {
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: itemsList, requiringSecureCoding: false)
      guard let path = retrieveItemsDirectory() else { return }
      
      try data.write(to: path)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func getItemListFromFile() -> [Item] {
    do {
      guard let path = retrieveItemsDirectory() else { return [] }
      let data = try Data(contentsOf: path)
      let storedItems = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! Array<Item>
      
      return storedItems
      
    } catch {
      print(error.localizedDescription)
      return []
    }
  }
  
  func retrieveItemsDirectory() -> URL? {
    guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
    let path = directory.appendingPathComponent("items")
    
    return path
  }
  
}
