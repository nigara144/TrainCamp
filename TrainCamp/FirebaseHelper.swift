//
//  FirebaseHelper.swift
//  TrainCamp
//
//  Created by mac on 20/06/2022.
//

import Foundation
import FirebaseFirestore


class FirebaseHelper {
    
    static let db = Firestore.firestore()
    
    
    static func getAllPlans() -> [Plan] {
        var plans : [Plan] = []
        db.collection("Plans").getDocuments() { (querySnapshot, err) in
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
        return plans
    }

    
}
