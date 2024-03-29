//
//  SceneDelegate.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/06/20.
//

import UIKit
import FirebaseAuth
import Reachability
import FirebaseFirestore
import Network

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let monitor = NWPathMonitor()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        configureInitialRootViewController(for: window)
        guard let _ = (scene as? UIWindowScene) else { return }
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}
extension SceneDelegate {
    
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
    
    func configureInitialRootViewController(for window: UIWindow?) {
        
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
        
        observeDisconnection()
        
        if let loggedEmail = Auth.auth().currentUser?.email, let defaultEmail = UserDefaults.standard.string(forKey: "Email"), let id = UserDefaults.standard.string(forKey: "ID"){
           print(loggedEmail)
            if loggedEmail == defaultEmail {
                let initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Nav") as! Navig
                
                initialViewController.window = window
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
}
