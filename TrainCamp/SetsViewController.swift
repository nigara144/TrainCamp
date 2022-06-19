//
//  SetsViewController.swift
//  TrainCamp
//
//  Created by mac on 18/06/2022.
//

import Foundation
import UIKit
import Firebase


class SetsViewController: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapOnLogoutBtn(_ sender: Any) {
        do{
            try FirebaseAuth.Auth.auth().signOut()
        
//            let vc = LoginViewController.self
//            let nav = UINavigationController(rootViewController: vc)
//
//            nav.modalPresentationStyle = .fullScreen
//            present(nav, animated: true)
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(loginViewController, animated:true, completion:nil)
            print("Logout - SUCCESS")
        }catch{
            print("Logout - FAILED")
        }
    }
    
    
}


