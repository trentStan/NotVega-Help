//
//  ClubTableViewCell.swift
//  NotVega Help
//
//  Created by IACD-019 on 2022/07/18.
//

import UIKit

class ClubTableViewCell: UITableViewCell {

    @IBOutlet weak var clubTitle: UILabel!
    @IBOutlet weak var clubIntro: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
