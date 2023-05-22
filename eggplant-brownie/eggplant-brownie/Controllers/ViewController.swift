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
  
  //MARK: - Atributes
  
  var delegate: AddMealDelegate?
  
  var itens = [Item(name: "molho de tomate", calories: 40.0),
               Item(name: "queijo", calories: 40.0),
               Item(name: "mangericão", calories: 40.0),
               Item(name: "azeite de oliva", calories: 40.0),
               Item(name: "alho", calories: 40.0),
               Item(name: "massa", calories: 40.0)]
  
  var selectedItens = [Item]()
  
  //MARK: - IBOutles
  
  @IBOutlet var nameTextField: UITextField?
  @IBOutlet weak var satisfactionTextField: UITextField?
  @IBOutlet weak var itensTableView: UITableView?

  //MARK: - View life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    let AddItemButton = UIBarButtonItem(title: "Add item", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addItem))
    navigationItem.rightBarButtonItem = AddItemButton
  }

  @objc func addItem() -> Void {
    let addItemViewController = AddItemViewController(delegate: self)
    navigationController?.pushViewController(addItemViewController, animated: true)
  }

  func add(_ item: Item) {
    itens.append(item)
    if let table = itensTableView {
      table.reloadData()
    } else {
      Alert(controller: self).show()
    }
    
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
      guard let path = retriveDirectory() else { return }
      
      try data.write(to: path)
    } catch {
      print(error.localizedDescription)
    }
  }

  func retriveDirectory() -> URL? {
    guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
    let path = directory.appendingPathComponent("itens")
    
    return path
  }
  
  //MARK: - UITableViewDataSource

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itens.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
    
    let tableRow = indexPath.row
    let item = itens[tableRow]
    
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
      
      selectedItens.append(itens[indexPath.row])
    } else {
      cell.accessoryType = .none
      selectedItens.removeAll { (item) -> Bool in
        return item.name == itens[indexPath.row].name
      }
      
      for selectedItem in selectedItens {
        print(selectedItem.name ?? "")
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
    
    let meal = Meal(name: mealName, satisfaction: satisfaction)
    
    meal.items = selectedItens
    
    return meal
  }
  
  //MARK: - IBActions
  
  @IBAction func addNewMeal(_ sender: Any) {
    guard let meal = validadeMealFormData() else {
      Alert(controller: self).show("Sorry", message: "Could not read meal form data properly.")
      return
    }
    
    delegate?.add(meal)
    navigationController?.popViewController(animated: true)
  
  }
}
