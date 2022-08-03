//
//  Navig.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/07/18.
//

import UIKit
import Network
import Reachability

class Navig: UINavigationController {
    
    let monitor = NWPathMonitor()
    
    var window: UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        observeDisconnection()
        // Do any additional setup after loading the view.
    }
    
    func observeDisconnection() {
        monitor.pathUpdateHandler = {
            path in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                
                /* let newScene = SceneDelegate()
                 newScene.window = self.window
                 newScene.configureInitialRootViewController(for: self.window) */
                let reachability = try! Reachability()
                switch reachability.connection {
                case .unavailable:
                    print("Network not reachable")
                    let errorViewController = UIStoryboard(name: "NoInternet", bundle: nil).instantiateViewController(withIdentifier: "NoInternet") as! NoInternet
                    errorViewController.window = self.window
                    self.window?.rootViewController = errorViewController
                    self.window?.makeKeyAndVisible()
                    return
                default:
                    print ("")
                    
                }
                
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
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
