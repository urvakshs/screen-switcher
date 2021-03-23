//
//  AlertGenerator.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 26/02/21.
//

import UIKit

// Will be used to generate alerts for various errors from different view controllers
struct AlertGenerator {
    
    func generateAlert(withTitle title: String, withMessage message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alertController
    }
}

struct ActionGenerator {
    func addAction(withTitle title: String, forAlert alert: UIAlertController) -> UIAlertController {
        // I don't want the action to do anything, these are just error type alerts
        let newAction = UIAlertAction(title: title, style: .default) { (action) in
            return
        }
        alert.addAction(newAction)
        return alert
    }
}
