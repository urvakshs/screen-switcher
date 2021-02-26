//
//  AlertGenerator.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 26/02/21.
//

import UIKit

struct AlertGenerator {
    
    func generateAlert(withTitle title: String, withMessage message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alertController
    }
    
    func addAction(withTitle title: String, forAlert alert: UIAlertController) -> UIAlertController {
        let newAction = UIAlertAction(title: title, style: .default) { (proceedAction) in
            return
        }
        
        alert.addAction(newAction)
        return alert
    }
}
