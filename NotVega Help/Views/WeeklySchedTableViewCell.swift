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
        
        scheduleView.layer.cornerRadius = 5
        scheduleView.layer.shadowColor = UIColor.gray.cgColor
        scheduleView.layer.shadowOpacity = 1
        scheduleView.layer.shadowOffset = .zero
        scheduleView.layer.shadowRadius = 10
        scheduleView.layer.shadowPath = UIBezierPath(rect: scheduleView.bounds).cgPath
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }  
}
