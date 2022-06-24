//
//  History.swift
//  TrainCamp
//
//  Created by mac on 24/06/2022.
//

import Foundation
import UIKit
import FirebaseFirestore

class History {
    var planName : String?
    var date : Timestamp?
    
    init() {
        planName = ""
        date = Timestamp()
    }
    
    init(planName : String, date : Timestamp) {
        self.planName = planName
        self.date = date
    }
    
}
