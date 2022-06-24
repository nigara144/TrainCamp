//
//  HistoryViewController.swift
//  TrainCamp
//
//  Created by mac on 18/06/2022.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var historyTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userModel.workoutHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let timestamp = userModel.workoutHistory[indexPath.row].date!.seconds
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
//        dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
//        dateFormatter.timeZone = .current
        
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let localDate = dateFormatter.string(from: date)
        
        var cell : CustomCell? = self.historyTableView.dequeueReusableCell(withIdentifier: "CustomHistoryCell") as? CustomCell
        cell?.CustomCell_LBL_cell?.text = "\(indexPath.row + 1). \(userModel.workoutHistory[indexPath.row].planName!) - \(localDate)"
        
        print("\(userModel.workoutHistory[indexPath.row].planName!) - \(userModel.workoutHistory[indexPath.row].date!)")
                
                if(cell == nil){
                    cell = CustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CustomHistoryCell")
                }
                
                return cell!
    }
}
    
