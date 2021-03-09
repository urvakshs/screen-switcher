//
//  LoginVC.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 08/02/21.
//

import UIKit
import LocalAuthentication
import AuthenticationServices

class LoginVC: UIViewController {
    private let contactSegue = "loginToContactDetails"
    private let iTunesSegue = "loginToItunes"
    @IBOutlet weak var touchIDButton: UIButton! // "Log in with Touch ID" button
    @IBOutlet weak var loginStackView: UIStackView! // Stack view used to manage the arrangement of the various login buttons
    
    // TODO: ADD TOUCH ID/FACE ID LOGIN
    private var context = LAContext()
    
    enum AuthenticationState {
        case loggedIn, loggedOut
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The biometryType, which affects this app's UI when state changes, is only meaningful
        //  after running canEvaluatePolicy. But make sure not to run this test from inside a
        //  policy evaluation callback (for example, don't put next line in the state's didSet
        //  method, which is triggered as a result of the state change made in the callback),
        //  because that might result in deadlock.
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)

        // Set the initial app state. This impacts the initial state of the UI as well.
        state = .loggedOut
        
        setupProviderLoginView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExistingAccountSetupFlows()
    }
    
    // The current authentication state.
    var state = AuthenticationState.loggedOut {

        // Update the UI on a change.
        didSet {
            touchIDButton.isHighlighted = state == .loggedIn  // The button text changes on highlight.

            // FaceID runs right away on evaluation, so you might want to warn the user.
            // In this app, show a special Face ID prompt if the user is logged out, but
            // only if the device supports that kind of authentication.
            // faceIDLabel.isHidden = (state == .loggedin) || (context.biometryType != .faceID)
        }
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
            self.performSegue(withIdentifier: self.contactSegue, sender: self)
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
        
    }
    
    // When login with touch/face ID is selected
    @IBAction func biometricsButtonPressed(_ sender: UIButton) {
        if state == .loggedIn {
            // Log out immediately.
            state = .loggedOut
        } else {
            // Get a fresh context for each login. If you use the same context on multiple attempts
            // then a previously successful authentication causes the next policy evaluation to
            // succeed without testing biometry again.
            context = LAContext()

            context.localizedCancelTitle = "Sign in using Apple ID"
            // First check if we have the needed hardware support.
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                let reason = "Log in to your account"
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                    if success {
                        // Move to the main thread because a state update triggers UI changes.
                        DispatchQueue.main.async { [unowned self] in
                            self.state = .loggedIn
                            self.performSegue(withIdentifier: self.iTunesSegue, sender: self)
                        }
                    } else {
                        print(error?.localizedDescription ?? "Failed to authenticate")
                        // Fall back to a asking for username and password.
                        // ...
                    }
                }
            } else {
                print(error?.localizedDescription ?? "Can't evaluate policy")

                // Fall back to a asking for username and password.
                // ...
            }
        }
    }
    
    func setupProviderLoginView() {
        let appleIDButton = ASAuthorizationAppleIDButton()
        // When the button is pressed, handleAuthorizationAppleIDButtonPress (objective-C) method is called
        appleIDButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        // Add the button to the login buttons' stack view
        self.loginStackView.addArrangedSubview(appleIDButton)
        // Make the height of the button the same as the others
        let heightConstraint = appleIDButton.heightAnchor.constraint(equalToConstant: touchIDButton.frame.size.height)
        appleIDButton.addConstraint(heightConstraint)
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc
    private func handleLogInWithAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
            
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    private func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        // ASAuthorizationAppleIDProvider is a mechanism for generating requests to authenticate users based on their Apple ID
        // ASAuthorizationPasswordProvider is a mechanism for generating requests to perform keychain credential sharing.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(), ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    /*
    // Tell the delegate that the authorisation completed successfully
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            self.saveUserInKeychain(userIdentifier)
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
        
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }*/
}

extension LoginVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Tell the delegate that the authorisation completed successfully
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            // Create an account in your system.
            // For the purpose of this demo app, store the these details in the keychain.
            /*KeychainItem.currentUserIdentifier = appleIDCredential.user
            KeychainItem.currentUserFirstName = appleIDCredential.fullName?.givenName
            KeychainItem.currentUserLastName = appleIDCredential.fullName?.familyName
            KeychainItem.currentUserEmail = appleIDCredential.email*/
            
            print("User Id - \(appleIDCredential.user)")
            print("User Name - \(appleIDCredential.fullName?.description ?? "N/A")")
            print("User Email - \(appleIDCredential.email ?? "N/A")")
            print("Real User Status - \(appleIDCredential.realUserStatus.rawValue)")
            
            if let identityTokenData = appleIDCredential.identityToken,
                let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
                print("Identity Token \(identityTokenString)")
            }
            
            // Show Home View Controller
            performSegue(withIdentifier: iTunesSegue, sender: self)
            
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // Show the password credential as an alert.
            DispatchQueue.main.async { // Displaying something or changing UI requires switching to main thread
                let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
                let alertController = UIAlertController(title: "Keychain Credential Received",
                                                        message: message,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    // Tells the delegate from which window it should present content to the user (required)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window!
    }
}
