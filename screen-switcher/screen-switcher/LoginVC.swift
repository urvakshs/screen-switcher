//
//  LoginVC.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 08/02/21.
//

import UIKit

class LoginVC: UIViewController { // Programmatic implementation of a tab bar controller
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didPressLogin(_ sender: UIButton) {
        // Create and present tab bar controller
        let tabBarVC = UITabBarController()
                
        // Create an instance of an alert controller
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        
        // Crete two simple UIAlertAction object (cancel and proceed)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancelAction) in
            return
        }
        
        // Closure in this action is used to bring up the tab bar controller once user presses "proceed"
        let proceedAction = UIAlertAction(title: "Proceed", style: .default) { (proceedAction) in
            
            // Create two instances of UIViewControllers and set some basic properties
            let vc1 = UIViewController()
            let vc2 = UIViewController()
            vc1.title = "Screen 1"
            vc2.title = "Screen 2"
            vc1.view.backgroundColor = .red
            vc2.view.backgroundColor = .blue
            tabBarVC.tabBar.isTranslucent = false // Set the tab bar's translucency effects off
            
            // Setting view controllers for the tab bar controller
            tabBarVC.setViewControllers([vc1, vc2], animated: false)
            tabBarVC.modalPresentationStyle = .fullScreen
            
            // Making the tab bar more presentable with the use of system icons
            if let items = tabBarVC.tabBar.items {
                let images = ["house", "gear"]
                for i in 0..<items.count {
                    items[i].image = UIImage(systemName: images[i])
                }
            }
            
            self.present(tabBarVC, animated: true) // "self" keyword is needed in closures
        }
        
        // Add the actions to the alert controller
        alertController.addAction(cancelAction)
        alertController.addAction(proceedAction)
        
        present(alertController, animated: true) {
            return
        }
        
    }
    
}
