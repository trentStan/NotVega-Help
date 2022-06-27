//
//  Protocols.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/06/21.
//

import Foundation

protocol Namable {
    
    var name: String { get }
}

protocol Contactable: Namable{
    var email: String { get  }
    var phoneNum: String { get }
}
