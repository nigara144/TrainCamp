//
//  PlanViewController.swift
//  TrainCamp
//
//  Created by mac on 18/06/2022.
//

import Foundation
import UIKit
import FirebaseFirestore

class PlanViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var planTitle: UILabel!
    @IBOutlet weak var textPlan: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    var titleP: String?
    let database = Firestore.firestore()
    var plan: Plan?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plan = plans.first(where: {$0.title == titleP})
        print("PLAN: \(plan)")
        setInfo()
        print("TEMP: \(plan!.title)")
        print("hfyt : \(plan!.title) \(plan!.title) \(plan!.title)")

    }
    
    func setInfo() {
        planTitle.text = titleP
        var str = ""
        var i = 0
        let currentPlan =  plan
        print("CURRENT PLAN: \(currentPlan) |||| titleP: \(titleP)")
        let currentExercises = currentPlan?.exercises ?? []
        for exercise in currentExercises {
            i = i + 1
            str = str + "\(exercise.name ?? "Exercise \(i)")  :  \(String(exercise.rounds)) x \(String(exercise.mul)) \n"
        }
        textPlan.text = str
        print(str)
       
    }
    
    @IBAction func clickBackBtn(_ sender: Any) {
        dismiss(animated:true, completion: nil)
    }
    
    
    @IBAction func clickStartBtn(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "StartWorkout") {
            let workoutView = segue.destination as! WorkoutViewController
            workoutView.titleP = plan?.title
        }
    }
        
    
}
