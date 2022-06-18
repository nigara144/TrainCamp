//
//  PlanViewController.swift
//  TrainCamp
//
//  Created by mac on 18/06/2022.
//

import Foundation
import UIKit

class PlanViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var planTitle: UILabel!
    @IBOutlet weak var textPlan: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickBackBtn(_ sender: Any) {
        dismiss(animated:true, completion: nil)
    }
    
    
    @IBAction func clickStartBtn(_ sender: Any) {
    }
    
}
