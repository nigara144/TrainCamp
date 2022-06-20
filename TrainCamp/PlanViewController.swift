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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo()
        print(plans)

    }
    
    func setInfo() {
        planTitle.text = titleP
    
    }
    
    @IBAction func clickBackBtn(_ sender: Any) {
        dismiss(animated:true, completion: nil)
    }
    
    
    @IBAction func clickStartBtn(_ sender: Any) {
        
    }
    
}
