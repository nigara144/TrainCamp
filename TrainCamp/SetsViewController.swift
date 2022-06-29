//
//  SetsViewController.swift
//  TrainCamp
//
//  Created by mac on 18/06/2022.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore


var plans = [Plan]()
var userModel = User()

class SetsViewController: UIViewController {
    
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnC: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        fetchPlans()
    }
    
    func fetchPlans() {
        Firestore.firestore().collection("Plans").order(by: "Title").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let plan = Plan()
                    let data = document.data()
                    plan.title = (data["Title"] as? String)
                    document.reference.collection("Exercises").getDocuments() {
                        (querySnapshot, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else {
                                for document in querySnapshot!.documents {
                                    print("\(document.documentID) => \(document.data())")
                                    let exercise = Exercise()
                                    let dataEx = document.data()
                                    exercise.img = (dataEx["img"] as? String)
                                    exercise.name = (dataEx["name"] as? String)
                                    exercise.rounds = (dataEx["rounds"] as? Int)
                                    exercise.mul = (dataEx["mul"] as? Int)
                                    plan.exercises.append(exercise)
                                }
                                plans.append(plan)
                            }
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(plans.isEmpty){
            let loader = self.loader()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.stopLoader(loader: loader)
            }
        }
        
    }
    
    
    func fetchUser() {
        if(userModel.email != ""){
            let userUID = Auth.auth().currentUser?.uid
            Firestore.firestore().collection("Users").document(userUID!).getDocument { snapshot, error in
                if error != nil {
                    print("ERROR: in Fetch User Data")
                }
                else {
                    print("SUCCESS: Fetch User Data")
                    userModel.email = snapshot?.get("email") as? String ?? Auth.auth().currentUser?.email
                    userModel.rank = snapshot?.get("rank") as? Int ?? 0
                    
                    snapshot?.reference.collection("History").getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting history documents: \(err)")
                            userModel.workoutHistory = []
                        } else {
                            for document in querySnapshot!.documents {
                                print("\(document.documentID) => \(document.data())")
                                userModel.workoutHistory.append(History(planName: document.get("planName") as! String, date: document.get("date") as! Timestamp))
                            }
                        }
                    }
                    print("USER DATA: \(userModel.email), \(userModel.rank), \(userModel.workoutHistory.count)")
                }
            }
        }
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
            userModel = User()
            plans = []
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(loginViewController, animated:true, completion:nil)
            
            print("Logout - SUCCESS")
            
        }catch{
            print("Logout - FAILED")
        }
    }
    
    
    
    
}

extension UIViewController {
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait", preferredStyle: .alert)
        
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func stopLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}


