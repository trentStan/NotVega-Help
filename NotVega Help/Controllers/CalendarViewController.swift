//
//  CalendarViewController.swift
//  NotVega Help
//
//  Created by IACD-021 on 2022/07/13.
//

import FSCalendar
import FirebaseFirestore
import UIKit

class CalendarViewController: UIViewController, FSCalendarDelegate {

    private let db = Firestore.firestore()
    var schedules: [Schedule] = []
    let cellSpacingHeight: CGFloat = 1
    @IBOutlet var eventsView: UITableView!
    @IBOutlet var calendar: FSCalendar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        eventsView.delegate = self
        
        
        
        var dateComponents = DateComponents()
        dateComponents.year = 2022
        dateComponents.month = 07
        dateComponents.day = 14
       
        
        let date = Calendar.current.date(from: dateComponents)!
        print(date)
        eventsView.backgroundView = nil
        eventsView.backgroundColor = UIColor.white
        
        eventsView.dataSource = self
        eventsView.delegate = self

        eventsView.register(UINib(nibName: "WeeklySchedTableViewCell", bundle: nil), forCellReuseIdentifier: "WeeklyScheduleCell")
        
        let selectedDay = DateFormatter().calendar.dateComponents([.weekday], from: date).weekday
        print("day:", selectedDay!)
        
        var day: String {
            
            switch selectedDay {
            case 2:
                return "01"
            case 3:
                return "02"
            case 4:
                return "03"
            case 5:
                return "04"
            case 6:
                return "05"
            default:
                return "01"
            }
        }
        
        calendar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        calendar.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        calendar.layer.shadowOpacity = 0.2
        calendar.layer.shadowRadius = 1.0
        calendar.layer.cornerRadius = 10
        
        loadSchedules(day: day)
        // Do any additional setup after loading the view.
    }
    
    func loadSchedules(day: String) {
        eventsView.reloadData()
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
                                self.eventsView.reloadData()
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("\(date), \(monthPosition.rawValue)")
       // calendar.cell(for: date, at: monthPosition)?.preferredFillDefaultColor = UIColor.green
        schedules = []
        let selectedDay = DateFormatter().calendar.dateComponents([.weekday], from: date).weekday
        print("day:", selectedDay!)
        
        var day: String {
            
            switch selectedDay {
            case 2:
                return "01"
            case 3:
                return "02"
            case 4:
                return "03"
            case 5:
                return "04"
            case 6:
                return "05"
            default:
                return "01"
            }
        }
        
        loadSchedules(day: day)
    }
    
    
}
extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return cellSpacingHeight
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventsView.dequeueReusableCell(withIdentifier: "WeeklyScheduleCell", for: indexPath) as! WeeklySchedTableViewCell
        cell.moduleName.text = schedules[indexPath.section].name
        cell.moduleTime.text = schedules[indexPath.section].time
        cell.moduleLecturer.text = schedules[indexPath.section].lecturer
        cell.moduleVenue.text = schedules[indexPath.section].classroom
        
        return cell
    }
    
    
    
}
