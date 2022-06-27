//
//  NoInternet.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/06/23.
//

import UIKit
import FirebaseAuth
import Reachability

class NoInternet: UIViewController {

     var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func reconnect(_ sender: Any) {
        let defaultEmail = UserDefaults.standard.string(forKey: "email")
        let initialViewController: UIViewController
        
        let reachability = try! Reachability()
        switch reachability.connection {
        case .wifi, .cellular:
            print("Reachable")
            break
        case .unavailable:
            print("Network not reachable")
           
            return
        default:
            print ("")
            
        }
        
        if let loggedEmail = Auth.auth().currentUser?.email{
            if loggedEmail == defaultEmail {
                initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
            } else {
                initialViewController = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "Login")
            }
            
        } else {
            initialViewController = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "Login")
        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
