//
//  User.swift
//  TrainCamp
//
//  Created by mac on 23/06/2022.
//

import Foundation
import UIKit

class User {
    var email : String?
    var rank : Int!
    var workoutHistory: [History]
    
    init() {
        email = ""
        rank = 0
        workoutHistory = []
    }
    
    init(email : String, rank : Int, workoutHistory: [History]) {
        self.email = email
        self.rank = rank
        self.workoutHistory = workoutHistory
    }
    
}
