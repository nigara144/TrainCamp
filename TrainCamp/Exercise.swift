//
//  Exercise.swift
//  TrainCamp
//
//  Created by mac on 19/06/2022.
//

import Foundation
import UIKit

class Exercise {
    var name : String?
    var img : String?
    var rounds : Int!
    var mul : Int!
    
    init(){
        name = ""
        img = ""
        rounds = 0
        mul = 0
    }
    
    init(name : String, img : String,rounds:Int,mul:Int) {
        self.name = name
        self.img = img
        self.rounds = rounds
        self.mul = mul
    }
    
//    func String toJson() {
//        let encodedData = try JSONEncoder().encode(Exercise.self)
//        let jsonString = String(data: encodedData,encoding: .utf8)
//
//        print(jsonString)
//        return jsonString
//    }
//    
//    func Exercise fromJson(String dataFromJson) {
//        let exerciseFromData
//        print(exerciseFromData)
//
//        if dataFromJson = jsonString?.data(using: .utf8) {
//            exerciseFromData = try JSONDecoder().decode(Exercise.self,from: dataFromJson)
//        }
//        return exerciseFromData
//    }
    
}

