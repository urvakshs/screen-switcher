//
//  OutputVC.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 23/03/21.
//

import UIKit

class OutputVC: UIViewController {
    var viewModel: ContactDetailsVM?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let viewModel = viewModel else {
            fatalError("Error unwrapping viewModel.")
        }

        nameLabel.text = viewModel.name
        phoneNumLabel.text = viewModel.phoneNum
        emailLabel.text = viewModel.email
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
