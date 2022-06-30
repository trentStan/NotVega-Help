//
//  User.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/06/21.
//

import Foundation
import UIKit


struct User: Contactable, Codable {
    
    var id: String
    var name: String
    var surname: String
    var phoneNum: String
    var email: String
    var eventIDs: [String]
    
    init(dic: [String: Any]) throws {
        self = try JSONDecoder().decode(User.self, from: JSONSerialization.data(withJSONObject: dic))
    }
}
func getUserDefaults() -> User? {
    var user: User?
    if let json =  UserDefaults.standard.object(forKey: "UserDetails") as? Data{
        
        do{
            
            user = try JSONDecoder().decode(User.self, from: json)
        } catch {
            print("Decoding user default failed")
        }
    } else {
        print("Decoding user default failed")
    }
    return user
}
