//
//  ViewController.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/06/20.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ViewController: UIViewController {
    
    var window: UIWindow?
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Main")
        addDefaults()
        
    }
    
    @IBAction func signOut(_ sender: Any) {
        
        let newScene = SceneDelegate()
        newScene.window = window
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.setValue(nil, forKey: "Email")
            UserDefaults.standard.setValue(nil, forKey: "ID")
            UserDefaults.standard.set(nil, forKey: "UserDetails")
        }
        catch{
            print("Cant Sign out")
            return
        }
        newScene.configureInitialRootViewController(for: window)
        
    }
    
    func addDefaults() {
        
        let users = db.collection("Users")
        guard let defaultEmail = UserDefaults.standard.string(forKey: "Email"), let ID = UserDefaults.standard.string(forKey: "ID") else {
            print("email and id error")
            return
        }
        let user = users.document(ID)
        print(ID)
        user.addSnapshotListener{ snap, error in
            
            if let error = error {
                print(error.localizedDescription)
                print("invoked")
            }
            
            if let snap = snap, snap.exists {
                
                do {
                    
                    if let dic = snap.data(){
                        let userDetails: User = try User.init(dic: dic)
                        UserDefaults.standard.set(try JSONEncoder().encode(userDetails), forKey: "UserDetails")
                        
                    }
                    
                }
                catch {
                    print("error")
                }
                
                
            }
            print("Welcome \(getUserDefaults()?.name ?? "Unknown")")
        }
        
    } // function addDefault
    
} // class

