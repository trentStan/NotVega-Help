//
//  LogIn.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/06/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class LogIn: UIViewController {
    
    private let db = Firestore.firestore()
    var window: UIWindow?
    
    @IBOutlet var ID: UITextField!
    @IBOutlet var Password: UITextField!
    @IBOutlet var errLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.string(forKey: "Email"))
        print("login loaded")
        errLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    private func checkAuth(enteredID: String, psw: String) -> Bool {
        let users = db.collection("Users")
        let user = users.document(enteredID)
        
        
        
        user.getDocument{ snap, error in
            if let error = error {
                print(error.localizedDescription)
                
            }
           
            if let snap = snap, snap.exists , let email = snap.data()!["email"] as? String {
                print("Email Retrieved: " + email)
                Auth.auth().signIn(withEmail: email, password: psw) { (result, error) in
                    if let error = error{
                        print("auth error: \(error.localizedDescription)")
                        self.showErr(description: "Incorrect Password")
                    } else {
                        UserDefaults.standard.set(result?.user.email, forKey: "Email")
                        UserDefaults.standard.synchronize()
                       
                        let initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main") as! ViewController
                        initialViewController.window = self.window
                        self.window?.rootViewController = initialViewController
                        self.window?.makeKeyAndVisible()
                    }
                }
                
                
            } else{
                print("email error")
                self.showErr(description: "Account does not exist")
            }
            
            
        }
        
        return false
    }
    
    func showErr(description: String){
        
        errLabel.text = description
        errLabel.alpha = 1
    }
    
    func hideErr(){
        errLabel.alpha = 0
    }
    
    @IBAction func logIn(_ sender: Any) {
        var success: Bool
        guard let enteredID = ID.text else {
            print("Enter ID")
            showErr(description: "Enter ID")
            return
        }
        
        if let psw = Password.text {
            
            success = checkAuth(enteredID: enteredID, psw: psw)
        } else {
            showErr(description: "Enter Password")
            print("Enter Password")
        }
    }
    
}
