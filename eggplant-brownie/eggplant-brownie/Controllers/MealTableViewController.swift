//
//  MealTableViewController.swift
//  eggplant-brownie
//
//  Created by Naiara de Almeida Pantuza on 12/05/23.
//

import UIKit

class MealTableViewController: UITableViewController, AddMealDelegate {


  //MARK: - attributes
  var meals = [Meal(name: "Brownie", satisfaction: 5),
               Meal(name: "Chocolat Muffin", satisfaction: 3),
               Meal(name: "Coconut Oil", satisfaction: 5),
               Meal(name: "Vanilla Cream", satisfaction: 2),
               Meal(name: "Chickpea Salad", satisfaction: 4),
               Meal(name: "Orange Cake", satisfaction: 5),
               Meal(name: "Potato Chips", satisfaction: 1)]

  // MARK: - View life cycle
  
  //MARK: - Loading meal data
  override func viewDidLoad() {
    guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    let path = directory.appendingPathComponent("meals")
    
    do {
      let data = try Data(contentsOf: path)
      guard let storedMeals = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<Meal> else { return }
      
      meals = storedMeals
    
    } catch {
      print(error.localizedDescription)
    }
    

  }

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
  
  //MARK: - Adding meal to meal data
  func add(_ meal: Meal) {
    meals.append(meal)
    guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    let path = directory.appendingPathComponent("meals")

    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
      try data.write(to: path)
    } catch {
      print(error.localizedDescription)
    }
    
    
    
    tableView.reloadData()
  }

  @objc func showDetails(recognizer: UILongPressGestureRecognizer) {
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

