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
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneNumField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewDetailsPressed(_ sender: UIButton) {
        guard let contactName = nameField.text else {
            fatalError("Could not unwrap nameField")
        }
        guard let contactPhone = phoneNumField.text else {
            fatalError("Could not unwrap phoneNumField")
        }
        guard let contactEmail = emailField.text else {
            fatalError("Could not unwrap emailField")
        }
        viewModel = ContactDetailsVM(contactName: contactName, contactPhone: contactPhone, contactEmail: contactEmail)
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? OutputVC {
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
