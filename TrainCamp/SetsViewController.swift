//
//  SetsViewController.swift
//  TrainCamp
//
//  Created by mac on 18/06/2022.
//

import Foundation
import UIKit
import Firebase

var plans = [Plan]()

class SetsViewController: UIViewController {
    
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnC: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plans = FirebaseHelper.getAllPlans()
//        print(plans)
    }
    
    
    @IBAction func choosePlan(_ sender: UIButton) {
        if(sender.tag == 1){
            performSegue(withIdentifier: "Plan_A", sender: self)
            print("Plan_A")
        }else if(sender.tag == 2){
            performSegue(withIdentifier: "Plan_B", sender: self)
            print("Plan_B")
        }else if(sender.tag == 3){
            performSegue(withIdentifier: "Plan_C", sender: self)
            print("Plan_C")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if (segue.identifier == "Plan_A") {
          let planView = segue.destination as! PlanViewController
           planView.titleP = "Plan A"
       }else if(segue.identifier == "Plan_B") {
           let planView = segue.destination as! PlanViewController
           planView.titleP = "Plan B"
       }else if(segue.identifier == "Plan_C") {
           let planView = segue.destination as! PlanViewController
           planView.titleP = "Plan C"
       }
    }
    
    @IBAction func tapOnLogoutBtn(_ sender: Any) {
        do{
            try FirebaseAuth.Auth.auth().signOut()
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(loginViewController, animated:true, completion:nil)
            
            print("Logout - SUCCESS")
            
        }catch{
            print("Logout - FAILED")
        }
    }
    
    
    
    
}


