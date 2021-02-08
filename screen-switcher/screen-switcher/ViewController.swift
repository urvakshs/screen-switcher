//
//  ViewController.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 02/02/21.
//

import UIKit

class ViewController: UIViewController {
    
    //private var singleton = Singleton()
    private var segueIdentifier = "forwardSegue"
    private var destinationVC = SecondViewController()
    private var observedText: Text!
    private var textObserver: TextObserver!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //print("Screen 1 viewDidLoad")
        observedText = Text()
        textObserver = TextObserver(object: observedText)
    }
    /*
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("Screen 1 viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("Screen 1 viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("Screen 1 viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("Screen 1 viewDidDisappear")
    }
    */
    @IBAction func nextPressed(_ sender: UIBarButtonItem) {
        Singleton.segueCount += 1
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if let textFieldText = textField.text {
            observedText.text = textFieldText
        }
        textField.text = ""
    }
}

