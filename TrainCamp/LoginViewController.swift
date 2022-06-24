//
//  LoginViewController.swift
//  TrainCamp
//
//  Created by user216966 on 6/8/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var userAlreadyExistsMsg: UILabel!
    
    
    func navigateToSetsView(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let setsViewController = storyBoard.instantiateViewController(withIdentifier: "SetsViewController") as! SetsViewController
        self.present(setsViewController, animated:true, completion:nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        Auth.auth().addStateDidChangeListener() { auth, user in
                if user != nil {
                    self.performSegue(withIdentifier: "UserLoggedIn", sender: nil)
                }
            }
    }
    
    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailAddressField.text
                {
                    if let errorMessage = invalidEmail(email)
                    {
                        emailError.text = errorMessage
                        emailError.isHidden = false
                    }
                    else
                    {
                        emailError.isHidden = true
                    }
                }
                
                checkForValidForm()
    }
    
    func invalidEmail(_ value: String) -> String?
        {
            let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
            if !predicate.evaluate(with: value)
            {
                return "Invalid Email Address"
            }
            
            return nil
        }
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = passwordField.text
                {
                    if let errorMessage = invalidPassword(password)
                    {
                        passwordError.text = errorMessage
                        passwordError.isHidden = false
                    }
                    else
                    {
                        passwordError.isHidden = true
                    }
                }
                
                checkForValidForm()
    }
    
    func invalidPassword(_ value: String) -> String?
    {
        if value.count < 6
        {
            return "Password must be at least 6 characters"
        }
        return nil
    }
    
    func checkForValidForm()
        {
            if emailError.isHidden && passwordError.isHidden
            {
                loginBtn.isEnabled = true
                signUp.isEnabled = true;
            }
            else
            {
                loginBtn.isEnabled = false
                signUp.isEnabled = false;
            }
        }
    
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
            self!.navigateToSetsView()
        }
    }
    
    
    @IBAction func createAccount(_ sender: Any) {
        let email = emailAddressField.text!
        let password = passwordField.text!
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if(error != nil) {
                print("User create - FAILED")
//                print(error)
                if((error! as NSError).code == 17007){
                    self.userAlreadyExistsMsg.isHidden = false

                }
                return
            }
            print("User created!")
            self.userSave(email: email, uuid: authResult!.user.uid)
            self.navigateToSetsView()
        }
    
    }
    
    func userSave(email: String, uuid: String) {
        let data = ["email": email, "rank" : 0] as [String : Any]
        FirebaseFirestore.Firestore.firestore().collection("Users").document(uuid).setData(data) { error in
            if error != nil {
                print("User save: FAILED")
            }
            else {
                print("User save: SUCCESS")
            }
        }
    }
    
    
    
    
}

