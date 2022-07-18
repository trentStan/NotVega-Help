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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
