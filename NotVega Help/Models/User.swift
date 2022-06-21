//
//  User.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/06/21.
//

import Foundation
import UIKit


struct User: Contactable {
    
    var id: String
    var name: String
    var surname: String
    var phoneNum: String
    var email: String
    var events: [Event]
    
}
