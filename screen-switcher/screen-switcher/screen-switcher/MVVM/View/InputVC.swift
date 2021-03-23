//
//  InputVC.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 23/03/21.
//

import UIKit

class InputVC: UIViewController {
    private var viewModel: ContactDetailsVM?
    private let segueIdentifier = "InputToOutput"
    
    // IB Outlets for text fields
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneNumField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewDetailsPressed(_ sender: UIButton) {
        // Unwrap all the text fields. No validation done in this simple example.
        guard let contactName = nameField.text, let contactPhone = phoneNumField.text, let contactEmail = emailField.text else {
            fatalError("Failure in unwrapping one of the three text fields nameField or phoneNumField or emailField")
        }
        // Initialise the view model
        viewModel = ContactDetailsVM(contactName: contactName, contactPhone: contactPhone, contactEmail: contactEmail)
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? OutputVC {
            // Pass this view model instance to the output view controller using prepare for segue method
            destinationVC.viewModel = self.viewModel
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
