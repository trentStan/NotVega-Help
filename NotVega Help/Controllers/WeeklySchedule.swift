//
//  WeeklySchedule.swift
//  NotVega Help
//
//  Created by IACD-021 on 2022/07/13.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class WeeklySchedule: UIViewController {
    @IBOutlet weak var scheduleTableView: UITableView!
    
    @IBOutlet weak var dailyView: UIView!
    
    private let db = Firestore.firestore()
    
    var schedules: [Schedule] = []
    let cellSpacingHeight: CGFloat = 1
    
    // Day buttons
    
    @IBOutlet var mon: UIButton!
    @IBOutlet var tues: UIButton!
    @IBOutlet var weds: UIButton!
    @IBOutlet var thurs: UIButton!
    @IBOutlet var fri: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyView.layer.cornerRadius = 20
        dailyView.layer.shadowColor = UIColor.lightGray.cgColor
        dailyView.layer.shadowOpacity = 1
        dailyView.layer.shadowOffset = .zero
        dailyView.layer.shadowRadius = 20
        dailyView.layer.shadowPath = UIBezierPath(rect: dailyView.bounds).cgPath
        
        scheduleTableView.backgroundView = nil
        scheduleTableView.backgroundColor = UIColor.white
        
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self

        scheduleTableView.register(UINib(nibName: "WeeklySchedTableViewCell", bundle: nil), forCellReuseIdentifier: "WeeklyScheduleCell")
        
        loadSchedules(day: "01")
    }
    
    func loadSchedules(day: String) {
        
        db.collection("WeeklySchedules").document(day).collection("Modules").order(by: "id").getDocuments { querySnapshot, error in
            if let e = error {
                print("Could not retrieve data from firestore: \(e)")
            } else {
                if let snapshotDocument = querySnapshot?.documents {
                    for doc in snapshotDocument {
                        let data = doc.data()
                        if let moduleName = data["name"] as? String, let moduleTime = data["time"] as? String, let moduleLecturer = data["lecturer"] as? String, let moduleVenue = data["venue"] as? String {
                            
                            let scheduleInfo = Schedule(name: moduleName, time: moduleTime, lecturer: moduleLecturer, classroom: moduleVenue)
                            self.schedules.append(scheduleInfo)
                            
                            DispatchQueue.main.async {
                                self.scheduleTableView.reloadData()
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func weekdayPressed(_ sender: UIButton) {
        
        schedules = []
        
        if let button = sender as? UIButton {
            mon.backgroundColor = UIColor.clear
            tues.backgroundColor = UIColor.clear
            weds.backgroundColor = UIColor.clear
            thurs.backgroundColor = UIColor.clear
            fri.backgroundColor = UIColor.clear
            if button.isSelected {
                button.backgroundColor = UIColor.clear
                print("Not Selected")
            } else {
                button.backgroundColor = UIColor(red: 0.80, green: 0.91, blue: 0.80, alpha: 1.00)
                button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
                button.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
                button.layer.shadowOpacity = 0.2
                button.layer.shadowRadius = 1.0
                button.layer.cornerRadius = 10
                print("Selected")
            }
        }
        
        let selectedDay = sender.titleLabel?.text
        
        var day: String {
            
            switch selectedDay! {
            case "Mon":
                return "01"
            case "Tue":
                return "02"
            case "Wed":
                return "03"
            case "Thu":
                return "04"
            case "Fri":
                return "05"
            default:
                return "01"
            }
        }
        
        loadSchedules(day: day)
        
    }

}

extension WeeklySchedule: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return cellSpacingHeight
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scheduleTableView.dequeueReusableCell(withIdentifier: "WeeklyScheduleCell", for: indexPath) as! WeeklySchedTableViewCell
        cell.moduleName.text = schedules[indexPath.section].name
        cell.moduleTime.text = schedules[indexPath.section].time
        cell.moduleLecturer.text = schedules[indexPath.section].lecturer
        cell.moduleVenue.text = schedules[indexPath.section].classroom
        
        return cell
    }
}
