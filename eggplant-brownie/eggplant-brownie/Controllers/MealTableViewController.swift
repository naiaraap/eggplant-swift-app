//
//  MealTableViewController.swift
//  eggplant-brownie
//
//  Created by Naiara de Almeida Pantuza on 12/05/23.
//

import UIKit

class MealTableViewController: UITableViewController, AddMealDelegate {

  //MARK: - attributes
  var meals: [Meal] = []

  // MARK: - View life cycle
  
  //MARK: - Loading meal data
  override func viewDidLoad() {
    meals = MealDao().getMealListFromFile()
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return meals.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "nil")
    let meal = meals[indexPath.row]
    cell.textLabel?.text = meal.name

    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showDetails(_:)))
    cell.addGestureRecognizer(longPress)

    return cell
  }
  
  //MARK: - Adding meal to meal data
  func add(_ meal: Meal) {
    meals.append(meal)
    tableView.reloadData()
    MealDao().save(meals)
  }

  @objc func showDetails(_ recognizer: UILongPressGestureRecognizer) {
    if recognizer.state == UIGestureRecognizer.State.began {
      let cell = recognizer.view as! UITableViewCell
      guard let indexPath = tableView.indexPath(for: cell) else { return }
      
      let meal = meals[indexPath.row]

      RemoveMealController(controller: self).show(meal, handler: { action in
        self.meals.remove(at: indexPath.row)
        self.tableView.reloadData()
      })
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

