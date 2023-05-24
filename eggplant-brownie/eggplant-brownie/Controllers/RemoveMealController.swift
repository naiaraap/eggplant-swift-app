//
//  RemoveMealController.swift
//  eggplant-brownie
//
//  Created by Naiara de Almeida Pantuza on 19/05/23.
//

import UIKit

class RemoveMealController {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
  func show(_ meal: Meal, handler: @escaping (UIAlertAction) -> Void) {
    let alert = UIAlertController(title: meal.name, message: meal.details(), preferredStyle: UIAlertController.Style.alert)
    
    let buttonCancel = UIAlertAction(title: "Cancell", style: UIAlertAction.Style.cancel)
    
    alert.addAction(buttonCancel)
    
    let removeButton = UIAlertAction(title: "Remove", style: UIAlertAction.Style.destructive, handler: handler)
    
    alert.addAction(removeButton)
    
    controller.present(alert, animated: true, completion: nil)
  }
}
