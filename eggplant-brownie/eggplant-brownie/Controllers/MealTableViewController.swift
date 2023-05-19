//
//  MealTableViewController.swift
//  eggplant-brownie
//
//  Created by Naiara de Almeida Pantuza on 12/05/23.
//

import UIKit

class MealTableViewController: UITableViewController, AddMealDelegate {
  
  var meals = [Meal(name: "Brownie", satisfaction: 5),
               Meal(name: "Chocolat Muffin", satisfaction: 3),
               Meal(name: "Coconut Oil", satisfaction: 5),
               Meal(name: "Vanilla Cream", satisfaction: 2),
               Meal(name: "Chickpea Salad", satisfaction: 4),
               Meal(name: "Orange Cake", satisfaction: 5),
               Meal(name: "Potato Chips", satisfaction: 1)]
    
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return meals.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "mealCellPrototype")
    let meal = meals[indexPath.row]
    cell.textLabel?.text = meal.name

    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showDetails))
    cell.addGestureRecognizer(longPress)

    return cell
  }
  
  func add(_ meal: Meal) {
    meals.append(meal)
    tableView.reloadData()
  }

  @objc func showDetails(recognizer: UILongPressGestureRecognizer) {
    if recognizer.state == UIGestureRecognizer.State.began {
      let cell = recognizer.view as! UITableViewCell
      guard let indexPath = tableView.indexPath(for: cell) else { return }
      
      let meal = meals[indexPath.row]
      
      let alert = UIAlertController(title: meal.name, message: meal.details(), preferredStyle: UIAlertController.Style.alert)
      
      let buttonCancel = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
      
      alert.addAction(buttonCancel)
      
      present(alert, animated: true, completion: nil)
      
      // RemoveMealController(controller: self).show(meal, handler: { action in
      //   self.meals.remove(at: indexPath.row)
      //   self.tableView.reloadData()
      // })
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "addmeal" {
      if let viewController = segue.destination as? ViewController {
        viewController.delegate = self
      }
    }
  }
}

