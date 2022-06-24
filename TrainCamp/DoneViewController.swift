//
//  DoneViewController.swift
//  TrainCamp
//
//  Created by mac on 18/06/2022.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

class DoneViewController: UIViewController {
    
    
    @IBOutlet weak var homeBtn: UIButton!
    var titleP: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateRank()
        addWorkoutToHistory()
    }
    
    func updateRank() {
        userModel.rank += 10
        let data = ["rank" : userModel.rank] as [String : Any]
        FirebaseFirestore.Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).updateData(data) { error in
            if error != nil {
                print("Update rank: FAILED")
            }
            else {
                print("Update rank: SUCCESS")
            }
        }
    }
    
    func addWorkoutToHistory() {
        let currentTimestamp = FirebaseFirestore.Timestamp.init(date: Date())
        let data = ["planName": titleP, "date" : currentTimestamp] as [String : Any]
        
        FirebaseFirestore.Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("History").addDocument(data: data) { error in
            if error != nil {
                print("Workout saved to History: FAILED")
            }
            else {
                print("Workout saved to History: SUCCESS")
                userModel.workoutHistory.append(History(planName: self.titleP!, date: currentTimestamp))
            }
        }
    }
}
