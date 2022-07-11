//
//  ClubDetailViewController.swift
//  NotVega Help
//
//  Created by IACD-019 on 2022/07/11.
//

import UIKit

class ClubDetailViewController: UIViewController {
    
    var cTitle: String?
    var cDay: String?
    var cTime: String?
    var cDescription: String?
    var cEmail: String?
    var cPhoneNum: String?
    
    @IBOutlet weak var clubImage: UIImageView!
    @IBOutlet weak var clubTitle: UILabel!
    @IBOutlet weak var clubDay: UILabel!
    @IBOutlet weak var clubTime: UILabel!
    @IBOutlet weak var clubDescView: UIView!
    @IBOutlet weak var clubDesc: UITextView!
    @IBOutlet weak var clubEmail: UILabel!
    @IBOutlet weak var clubPhoneNum: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clubDescView.layer.cornerRadius = 10
        clubTitle.text = cTitle
        clubDay.text = cDay
        clubTime.text = cTime
        clubDesc.text = cDescription
        clubEmail.text = cEmail
        clubPhoneNum.text = cPhoneNum
    }
}
