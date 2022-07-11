//
//  Club.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/06/21.
//

import Foundation

struct Club: Contactable, CustomStringConvertible, Codable{
    
    var name: String
    var intro: String
    var day: String
    var time: String
    var description: String
    var email: String
    var phoneNum: String
    var eventIDs: [String]
}
