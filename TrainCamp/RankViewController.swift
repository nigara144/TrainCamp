//
//  RankViewController.swift
//  TrainCamp
//
//  Created by mac on 20/06/2022.
//

import Foundation
import UIKit
import FirebaseFirestore

class RankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var rankTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    var users : [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankTableView.delegate = self
        rankTableView.dataSource = self
        getTopTenUsers()
    }
    
    @IBAction func clickOnBackBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func getTopTenUsers() {
        Firestore.firestore().collection("Users").order(by: "rank", descending: true).limit(to: 10).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting Users documents: \(err)")
            } else {
                print("User added to TOP TEN rank!!!")
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.users.append(User(email: document.get("email") as! String, rank: document.get("rank") as! Int, workoutHistory: []))
                }
                self.rankTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : CustomCellRank? = self.rankTableView.dequeueReusableCell(withIdentifier: "CustomCellRank") as? CustomCellRank
        cell?.CustomCell_LBL_rank?.text = "\(indexPath.row + 1). \(users[indexPath.row].email!) - \(users[indexPath.row].rank ?? 0)"
            if(cell == nil){
                cell = CustomCellRank(style: UITableViewCell.CellStyle.default,reuseIdentifier: "CustomCellRank")
            }
        return cell!
    }
    
}



