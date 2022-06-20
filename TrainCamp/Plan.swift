//
//  Plan.swift
//  TrainCamp
//
//  Created by mac on 20/06/2022.
//


import Foundation
import UIKit

class Plan {
    var title : String?
    var exercises : [Exercise]
    
    init() {
        title = ""
        exercises = []
    }
    
    init(title : String, exercises : [Exercise]) {
        self.title = title
        self.exercises = exercises
    }
    
}
