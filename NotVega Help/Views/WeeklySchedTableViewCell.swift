//
//  WeeklySchedTableViewCell.swift
//  NotVega Help
//
//  Created by IACD-019 on 2022/07/18.
//

import UIKit

class WeeklySchedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moduleName: UILabel!
    @IBOutlet weak var moduleTime: UILabel!
    @IBOutlet weak var moduleLecturer: UILabel!
    @IBOutlet weak var moduleVenue: UILabel!
    @IBOutlet weak var scheduleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scheduleView.layer.cornerRadius = 10
        scheduleView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        scheduleView.layer.shadowOpacity = 0.1
        scheduleView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        scheduleView.layer.shadowRadius = 1.0
        //scheduleView.layer.shadowPath = UIBezierPath(rect: scheduleView.bounds).cgPath
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }  
}
