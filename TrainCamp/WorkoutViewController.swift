//
//  WorkoutViewController.swift
//  TrainCamp
//
//  Created by mac on 18/06/2022.
//

import Foundation
import UIKit

class WorkoutViewController: UIViewController {
    
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var workoutTitle: UILabel!
    @IBOutlet weak var workoutImg: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var titleP: String?
    var timer: Timer?
    var timeLeft = 5
    var countOfRounds: Int = 1
    var countOfExercises: Int = 0
    var rest: Bool = true
    var currentExercises: [Exercise] = []
    var isPaused: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo()
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    
    
    @IBAction func clickOnStop(_ sender: Any) {
        timer?.invalidate()
    }
    
    
    @IBAction func clickOnPauseAndResume(_ sender: Any) {
        if(!isPaused){
            pauseBtn.setTitle("Resume", for: .normal)
            timer?.invalidate()
            isPaused = true
        }else{
            isPaused = false
            pauseBtn.setTitle("Pause", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func fireTimer() {
        print("Timer fired!")
        
        if(rest == true){
            timerLabel.text = "\(timeLeft) seconds to start"
        }else{
            timerLabel.text = String(timeLeft)
        }
        timeLeft -= 1
        
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            
            if(rest == true){
                rest = false
            }
            else{
                if(countOfRounds >= currentExercises[countOfExercises].rounds){
                    countOfExercises = countOfExercises + 1
                    countOfRounds = 1
                }else{
                    countOfRounds = countOfRounds + 1
                }
                rest = true
            }
            if(countOfExercises <= 2) {
                if(rest == true){ // change this timeLeft to rest timer seconds
                    timeLeft = 5
                }else{// change this timeLeft to workout timer seconds
                    timeLeft = 7
                }
                setInfo()
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
            }else {
                //workout done
                performSegue(withIdentifier: "WorkoutDone", sender: self)                
            }
        }
    }
    

    func setInfo() {
        let currentPlan = plans.first(where: {$0.title == titleP})
        currentExercises = currentPlan?.exercises ?? []
        workoutTitle.text = currentExercises[countOfExercises].name
        if let url = URL(string: currentExercises[countOfExercises].img!) {
            workoutImg?.load(url: url)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "WorkoutDone") {
            let doneView = segue.destination as! DoneViewController
            doneView.titleP = titleP
        }
    }
}



extension UIImageView {
    func load(url: URL, onLoadCompletion: ((_ isImageLoaded: Bool) -> Void)? = nil) {
        self.image = nil
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        onLoadCompletion?(true)
                    }
                } else {
                    onLoadCompletion?(false)
                }
            } else {
                onLoadCompletion?(false)
            }
        }
    }
}
