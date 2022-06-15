import Foundation
import UIKit
import FirebaseAuth
//import XCTest
//import FirebaseAuthUI
//import FirebaseUI

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
       
    }
    
//    @IBAction func createAccount(_ sender: Any) {
//        let email = emailAddressField.text!
//        let password = passwordField.text!
////        let name = nameField.text!
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if(error != nil) {
//                print("User create - FAILED")
////                print(error)
//                return
//            }
//            print("User created!")
//        }
//    }
}
