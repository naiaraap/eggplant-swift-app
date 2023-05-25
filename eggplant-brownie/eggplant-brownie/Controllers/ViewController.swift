//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Naiara de Almeida Pantuza on 13/05/23.
//

import UIKit

protocol AddMealDelegate {
  func add(_ meal: Meal)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddAnItemDelegate {
  
  //MARK: - IBOutles
  
  @IBOutlet var nameTextField: UITextField?
  
  //MARK: - Atributes
  
  var delegate: AddMealDelegate?
  var items: [Item] = []
  
  var selectedItems = [Item]()
  
  //MARK: - IBOutles
  
  @IBOutlet var satisfactionTextField: UITextField?
  @IBOutlet weak var itemsTableView: UITableView?
  

  //MARK: - View life cycle

  override func viewDidLoad() {
    let AddItemButton = UIBarButtonItem(title: "Add item", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addItem))
    navigationItem.rightBarButtonItem = AddItemButton
    retrieveStoredItens()
    
  }
  
  func retrieveStoredItens() {
    items = ItemDao().getItemListFromFile()
  }

  @objc func addItem() -> Void {
    let addItemViewController = AddItemViewController(delegate: self)
    navigationController?.pushViewController(addItemViewController, animated: true)
  }

  func add(_ item: Item) {
    items.append(item)
    ItemDao().save(items)
    
    if let tableView = itemsTableView {
      tableView.reloadData()
    } else {
      Alert(controller: self).show(message: "Erro ao atualizar tabela")
    }
  }
  
  //MARK: - UITableViewDataSource

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
    
    let tableRow = indexPath.row
    let item = items[tableRow]
    
    cell.textLabel?.text = item.name
    
    return cell
  }
  
  //MARK: - UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) else {
      return
    }
    if cell.accessoryType == .none {
      cell.accessoryType = .checkmark
      let tableRow = indexPath.row
      selectedItems.append(items[tableRow])
    } else {
      cell.accessoryType = .none
      
      let item = items[indexPath.row]
      if let position = selectedItems.firstIndex(of: item) {
        selectedItems.remove(at: position)
      }
    }
  }

  func validadeMealFormData() -> Meal? {
    guard let mealName = nameTextField?.text else {
      return nil
    }
    
    guard let mealSatisfaction = satisfactionTextField?.text, let satisfaction = Int(mealSatisfaction) else {
      return nil
    }
    
    let meal = Meal(name: mealName, satisfaction: satisfaction, items: selectedItems)
    
    return meal
  }
  
  //MARK: - IBActions
  
  @IBAction func addNewMeal(_ sender: Any) {
    if let meal = validadeMealFormData() {
      delegate?.add(meal)
      navigationController?.popViewController(animated: true)
    } else {
      Alert(controller: self).show("Sorry", message: "Could not read meal form data properly.")
    }
  }
}
