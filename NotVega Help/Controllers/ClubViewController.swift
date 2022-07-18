//
//  ClubViewController.swift
//  NotVega Help
//
//  Created by IACD-019 on 2022/07/11.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ClubViewController: UIViewController {
    
    @IBOutlet weak var clubTableView: UITableView!
    
    private let db = Firestore.firestore()
    var cTitle: String?
    var cDay: String?
    var cTime: String?
    var cDescription: String?
    var cEmail: String?
    var cPhoneNum: String?
    var clubInformation: [Club] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Clubs"
        
        clubTableView.delegate = self
        clubTableView.dataSource = self
        clubTableView.register(UINib(nibName: "ClubTableViewCell", bundle: nil), forCellReuseIdentifier: "ClubReusableCell")
        
        loadClubs()
    }
    
    func loadClubs() {
        
        db.collection("Clubs").getDocuments { querySnapshot, error in
            if let e = error {
                print("There was an error retrieving data from Firestore: \(e)")
            } else {
                if let snapshotDocument = querySnapshot?.documents {
                    for doc in snapshotDocument {
                        let data = doc.data()
                        if let name = data["name"] as? String,
                           let clubIntro = data["intro"] as? String,
                           let clubDesc = data["description"] as? String,
                           let clubDay = data["day"] as? String,
                           let clubTime = data["time"] as? String,
                           let clubEmail = data["email"] as? String,
                           let clubPhoneNum = data["phoneNum"] as? String,
                           let clubEventIDs = data["eventIDs"] as? [String] {
                            
                            let clubInfo = Club(name: name, intro: clubIntro, day: clubDay, time: clubTime, description: clubDesc, email: clubEmail, phoneNum: clubPhoneNum, eventIDs: clubEventIDs)
                            self.clubInformation.append(clubInfo)
                            
                            DispatchQueue.main.async {
                                self.clubTableView.reloadData()
                            }
                        }
                    }
                } // snapshotDoc
            }
        } // db.collections
    } // func loadClubs
}

// Populating the Table View
extension ClubViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = clubTableView.dequeueReusableCell(withIdentifier: "ClubReusableCell", for: indexPath) as! ClubTableViewCell
        cell.clubTitle.text = clubInformation[indexPath.row].name
        cell.clubIntro.text = clubInformation[indexPath.row].intro
        return cell
    }
}

// Table View Interaction
extension ClubViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? ClubDetailViewController {
            DispatchQueue.main.async {
                self.cTitle = self.clubInformation[indexPath.row].name
                self.cDay = self.clubInformation[indexPath.row].day
                self.cTime = self.clubInformation[indexPath.row].time
                self.cDescription = self.clubInformation[indexPath.row].description
                self.cEmail = self.clubInformation[indexPath.row].email
                self.cPhoneNum = self.clubInformation[indexPath.row].phoneNum
                self.performSegue(withIdentifier: "ClubDetails", sender: self)
                
            }
        }
    }// didSelectRowAt function
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ClubDetails" {
            let clubDetailVC = segue.destination as! ClubDetailViewController
            clubDetailVC.cTitle = cTitle
            clubDetailVC.cDay = cDay
            clubDetailVC.cTime = cTime
            clubDetailVC.cDescription = cDescription
            clubDetailVC.cEmail = cEmail
            clubDetailVC.cPhoneNum = cPhoneNum
        }
    }
}
