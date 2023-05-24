//
//  AddItemViewController.swift
//  eggplant-brownie
//
//  Created by Naiara de Almeida Pantuza on 16/05/23.
//

import UIKit

protocol AddAnItemDelegate {
  func add(_ item: Item)
}

class AddItemViewController: UIViewController {

  //MARK: - IBOutlets

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var caloriesTextField: UITextField!
  
  //MARK: - Attributes

  var delegate: AddAnItemDelegate?

  init(delegate: AddAnItemDelegate) {
    super.init(nibName: "AddItemViewController", bundle: nil)
    self.delegate = delegate
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  //MARK: - view life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK: - IBAcctions
  
  @IBAction func addItem(_ sender: Any) {
    guard let name = nameTextField.text, let textCalories = caloriesTextField.text else {
      return
    }
    if let calories = Double(textCalories) {
      let item = Item(name: name, calories: calories)
      delegate?.add(item)
      navigationController?.popViewController(animated: true)
    }
  }
}
