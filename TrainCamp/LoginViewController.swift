//
//  LoginViewController.swift
//  TrainCamp
//
//  Created by user216966 on 6/8/22.
//

import Foundation
import UIKit
import FirebaseAuth
//import FirebaseUI

class LoginViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
       
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // 1
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }

        // 2
        authUI.delegate = self

        // 3
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
}
