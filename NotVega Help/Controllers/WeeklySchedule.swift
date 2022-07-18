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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleTableView.dataSource = self

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

extension WeeklySchedule: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scheduleTableView.dequeueReusableCell(withIdentifier: "WeeklyScheduleCell", for: indexPath) as! WeeklySchedTableViewCell
        cell.moduleName.text = schedules[indexPath.row].name
        cell.moduleTime.text = schedules[indexPath.row].time
        cell.moduleLecturer.text = schedules[indexPath.row].lecturer
        cell.moduleVenue.text = schedules[indexPath.row].classroom
        return cell
    }
    
    
}
