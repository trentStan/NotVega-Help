//
//  MessageCell.swift
//  NotVega Help
//
//  Created by IACD-019 on 2022/07/21.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var messageBuble: UIView!
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // To allow the message buble to be extendable
        messageBuble.layer.cornerRadius = messageBuble.frame.size.height / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
