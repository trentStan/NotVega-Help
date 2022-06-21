//
//  Event.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/06/21.
//

import Foundation

struct Event: Identifiable{
    var id: ObjectIdentifier
    var title: String
    var dateTime: Date
    var location: String
    var descript: String
    
}
