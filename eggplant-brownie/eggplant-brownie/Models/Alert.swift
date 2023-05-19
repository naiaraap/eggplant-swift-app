//
//  Alert.swift
//  eggplant-brownie
//
//  Created by Naiara de Almeida Pantuza on 17/05/23.
//

import UIKit

class Alert {
  
  //MARK: - Atributes
  
  let controller: UIViewController
  
  //MARK: - Init
  
  init(controller: UIViewController) {
    self.controller = controller
  }
  
  //MARK: - Methods
  
  func show(_ title: String = "Sorry", message: String = "Unexpected error") {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
    let buttonCancel = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
    
    alert.addAction(buttonCancel)
    
    controller.present(alert, animated: true, completion: nil)
  }
  
}
