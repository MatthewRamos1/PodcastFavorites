//
//  UIViewContoller + Alerts.swift
//  PodcastFavorites
//
//  Created by Matthew Ramos on 12/17/19.
//  Copyright © 2019 Matthew Ramos. All rights reserved.
//

import UIKit

extension UIViewController {
  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}
