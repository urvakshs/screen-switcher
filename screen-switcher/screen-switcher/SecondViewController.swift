//
//  SecondViewController.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 03/02/21.
//

import UIKit

class SecondViewController: UIViewController, VCTextDelegate {
    
    func passString(string: String) {
        print("String received is \(string)")
    }

    @IBOutlet weak var segueCountLabel: UILabel!
    @IBOutlet weak var textFieldLabel: UILabel!
    
    var delegate: VCTextDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Updating the label to display number of forwardSegue performed
        segueCountLabel.text = "Number of segues = \(ViewController.segueCount)"
        print("VC2 viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("VC2 viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("VC2 viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("VC2 viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("VC2 viewDidDisappear")
    }
}
