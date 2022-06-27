//
//  ViewController.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/06/20.
//

import UIKit
import FirebaseAuth
import Reachability

class ViewController: UIViewController {
    
    var window: UIWindow?
    
    @IBAction func signOut(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.setValue(nil, forKey: "Email")}
        catch{
            print("Cant Sign out")
            return
        }
        let defaultEmail = UserDefaults.standard.string(forKey: "Email")
        
        
        let reachability = try! Reachability()
        switch reachability.connection {
        case .wifi, .cellular:
            print("Reachable")
            break
        case .unavailable:
            print("Network not reachable")
            let errorViewController = UIStoryboard(name: "NoInternet", bundle: nil).instantiateViewController(withIdentifier: "NoInternet") as! NoInternet
            errorViewController.window = window
            window?.rootViewController = errorViewController
            window?.makeKeyAndVisible()
            return
        default:
            print ("")
            
        }
        
        if let loggedEmail = Auth.auth().currentUser?.email{
            
            if loggedEmail == defaultEmail {
                let initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
                window?.rootViewController = initialViewController
            } else {
                let initialViewController = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LogIn
                initialViewController.window = window
                window?.rootViewController = initialViewController
            }
            
        } else {
            let initialViewController = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LogIn
            initialViewController.window = window
            window?.rootViewController = initialViewController
        }
        
        
        window?.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserDefaults.standard.string(forKey: "Email"))
        print("Main")
    }
    
    
}

