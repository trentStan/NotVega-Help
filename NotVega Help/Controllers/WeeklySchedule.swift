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
    private let db = Firestore.firestore()
    
    var schedules: [Schedule] = []
    let cellSpacingHeight: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleTableView.dataSource = self
//        scheduleTableView.delegate = self

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
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//           return cellSpacingHeight
//       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scheduleTableView.dequeueReusableCell(withIdentifier: "WeeklyScheduleCell", for: indexPath) as! WeeklySchedTableViewCell
        cell.moduleName.text = schedules[indexPath.section].name
        cell.moduleTime.text = schedules[indexPath.section].time
        cell.moduleLecturer.text = schedules[indexPath.section].lecturer
        cell.moduleVenue.text = schedules[indexPath.section].classroom
        
//        cell.backgroundView?.layer.cornerRadius = 5
//        cell.backgroundView?.clipsToBounds = true
        return cell
    }
}
