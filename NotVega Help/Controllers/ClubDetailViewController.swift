//
//  ClubDetailViewController.swift
//  NotVega Help
//
//  Created by IACD-019 on 2022/07/11.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ClubDetailViewController: UIViewController {
    
    private let db = Firestore.firestore()
    
    var cTitle: String?
    var cDay: String?
    var cTime: String?
    var cDescription: String?
    var cEmail: String?
    var cPhoneNum: String?
    
    @IBOutlet weak var clubImage: UIImageView!
    @IBOutlet weak var clubTitle: UILabel!
    @IBOutlet weak var clubInto: UILabel!
    @IBOutlet weak var clubDay: UILabel!
    @IBOutlet weak var clubTime: UILabel!
    @IBOutlet weak var clubDesc: UITextView!
    @IBOutlet weak var clubEmail: UILabel!
    @IBOutlet weak var clubPhoneNum: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubTitle.text = cTitle
        clubDay.text = cDay
        clubTime.text = cTime
        clubDesc.text = cDescription
        clubEmail.text = cEmail
        clubPhoneNum.text = cPhoneNum
    }
    
    @IBAction func addToCalandarPressed(_ sender: Any) {
        
        var day: String {
        
            switch cDay {
            case "Tuesdays":
                return "02"
            case "Wednesdays":
                return "03"
            case "Fridays":
                return "05"
            default:
                return "04"
            }
        }
        
        db.collection("WeeklySchedules").document(day).collection("Modules").addDocument(data: [
            "id": 5,
            "lecturer": cPhoneNum as Any,
            "name": cTitle as Any,
            "time": cTime as Any,
            "venue": cEmail as Any
        ]) { (error) in
            if let e = error {
                print("Could not update Schedule data to Firestore: \(e)")
            } else {
                print("Successfully added")
            }
        }
    }
    
    
}
