//
//  NoInternet.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/06/23.
//

import UIKit

class NoInternet: UIViewController {

     var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func reconnect(_ sender: Any) {
        let newScene = SceneDelegate()
        newScene.window = window
        newScene.configureInitialRootViewController(for: window)
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
