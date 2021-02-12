//
//  LoginVC.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 08/02/21.
//

import UIKit

class LoginVC: UIViewController { // Programmatic implementation of a tab bar controller
    private let segueIdentifier = "loginToContactDetails"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didPressLogin(_ sender: UIButton) {
        // Create and present tab bar controller
        let tabBarVC = UITabBarController()
        
        // Create an instance of an alert controller (action sheet style)
        let actionSheetAlertController = UIAlertController(title: "Do you wish to proceed?", message: "", preferredStyle: .actionSheet)
        
        // Create an instance of an alert controller (default style)
        let defaultAlertController = UIAlertController(title: "Do you wish to proceed?", message: "", preferredStyle: .alert)
        
        // Different types of action styles:
        // 1. .default - Apply the default style to the action’s button.
        // 2. .cancel - Apply a style that indicates the action cancels the operation and leaves things unchanged.
        // 3. .destructive - Apply a style that indicates the action might change or delete data (
        
        // Create two simple UIAlertAction object (cancel and proceed)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancelAction) in
            return
        }
        
        // Closure (action to be done) in this alertAction is used to bring up the tab bar controller once user presses "proceed"
        let proceedAction = UIAlertAction(title: "Proceed", style: .default) { (proceedAction) in
            /*
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
            tabBarVC.modalPresentationStyle = .fullScreen // We want the new VCs to take over the full screen instead of being presented like a stack of cards
            
            // Making the tab bar more presentable with the use of system icons
            if let items = tabBarVC.tabBar.items {
                let images = ["house", "gear"]
                for i in 0..<items.count {
                    items[i].image = UIImage(systemName: images[i])
                }
            }
            self.present(tabBarVC, animated: true) // "self" keyword is needed in closures
            */
            self.performSegue(withIdentifier: self.segueIdentifier, sender: self)
            
        }
        
        // NOTE TO SELF: CODE WILL FAIL (NOT PROCEED TO TAB BAR CONTROLLER) IF YOU ADD SAME SET OF ACTIONS TO BOTH ALERT CONTROLLERS
        
        // Add the actions to the alert controllers
        defaultAlertController.addAction(cancelAction)
        defaultAlertController.addAction(proceedAction)
        
        //actionSheetAlertController.addAction(cancelAction)
        //actionSheetAlertController.addAction(proceedAction)
        
        
        // Present alert controller to user
    
        
        present(defaultAlertController, animated: true) { // Completion handler is unused in this case
            return
        }
        /*
        present(actionSheetAlertController, animated: true) { // Completion handler is unused in this case
            return
        }*/
    }
    
}
