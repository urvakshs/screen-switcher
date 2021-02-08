//
//  SecondViewController.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 03/02/21.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var segueCountLabel: UILabel!
    @IBOutlet weak var textFieldLabel: UILabel!
    var segueCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Screen 2 viewDidLoad")
        // Do any additional setup after loading the view.
        if let count = segueCount {
            segueCountLabel.text = "Number of segues = \(count)"
        }
        else {
            segueCountLabel.text = "Number of segues = 0"
        }
    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("Screen 2 viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("Screen 2 viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("Screen 2 viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("Screen 2 viewDidDisappear")
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
