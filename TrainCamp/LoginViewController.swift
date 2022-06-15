//
//  LoginViewController.swift
//  TrainCamp
//
//  Created by user216966 on 6/8/22.
//

import Foundation
import UIKit
import Firebase
//import FirebaseUI

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
//    var handle: AuthStateDidChangeListenerHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
       
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        handle = Auth.auth().addStateDidChangeListener { auth, user in}
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        Auth.auth().removeStateDidChangeListener(handle!)
//    }
    
    
    @IBAction func didTapOnLoginButton(_ sender: AnyObject){
        let email = emailAddressField.text!
                let password = passwordField.text!

                Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
                    guard let strongSelf = self else { return }
                    if(error != nil) {
                        print("Login - FAILED")
                        return
                    }
                    print("Login - SUCCESS")
                }
    }
    
    @IBAction func createAccount(_ sender: Any) {
        let email = emailAddressField.text!
        let password = passwordField.text!
//        let name = nameField.text!
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if(error != nil) {
                print("User create - FAILED")
//                print(error)
                return
            }
            print("User created!")
        }
    
    }
    
//    @IBAction func loginButtonTapped(_ sender: UIButton) {
//        guard let authUI = FUIAuth.defaultAuthUI()
//            else { return }
//
//        authUI.delegate = self
//
//        let authViewController = authUI.authViewController()
//        present(authViewController, animated: true)
//    }
}

