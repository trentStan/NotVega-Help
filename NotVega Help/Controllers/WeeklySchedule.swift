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

        scheduleTableView.register(UINib(nibName: "WeeklySchedTableViewCell", bundle: nil), forCellReuseIdentifier: "WeeklyScheduleCell")
    }
    
    func loadSchedules(day: String) {
        
    }
    
    @IBAction func weekdayPressed(_ sender: UIButton) {
        
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
        
        print(day)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WeeklySchedule: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scheduleTableView.dequeueReusableCell(withIdentifier: "WeeklyScheduleCell", for: indexPath) as! WeeklySchedTableViewCell
        
        return cell
    }
    
    
}
