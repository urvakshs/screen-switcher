//
//  ViewController.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 02/02/21.
//

import UIKit

class ViewController: UIViewController, VCTextDelegate {
    private var segueIdentifier = "forwardSegue"
    private var observedText: Text!
    private var textObserver: TextObserver!
    static var segueCount = 0 // This will update each time a forward segue is performed and will be displayed on secondVC
    @IBOutlet weak var textField: UITextField! // IBOutlet for text field that will be observed for changes

    override func viewDidLoad() {
        super.viewDidLoad()
        observedText = Text()
        textObserver = TextObserver(object: observedText)
        //print("VC1 viewDidLoad")
    }
    
    @IBAction func nextPressed(_ sender: UIBarButtonItem) {
        ViewController.segueCount += 1
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? SecondViewController {
            secondVC.delegate = self
            guard let text = textField.text else {
                return
            }
            secondVC.passString(string: text)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if let textFieldText = textField.text {
            observedText.text = textFieldText
        }
        textField.text = "" // After change is observed, set textField back to empty
    }
    
    func passString(string: String) { // Required protocol function
        return // Not needed to do anything in this VC
    }
    
    /*
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("VC1 viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("VC1 viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("VC1 viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("VC1 viewDidDisappear")
    }*/
}
