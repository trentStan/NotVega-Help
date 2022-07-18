//
//  LogIn.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/06/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

extension UIImage {

    func addImagePadding(x: CGFloat, y: CGFloat) -> UIImage? {
        let width: CGFloat = size.width + x
        let height: CGFloat = size.height + y
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        let origin: CGPoint = CGPoint(x: (width - size.width) / 2, y: (height - size.height) / 2)
        draw(at: origin)
        let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithPadding
    }
}

class LogIn: UIViewController {
    
    private let db = Firestore.firestore()
    var window: UIWindow?
    
    @IBOutlet weak var ID: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet var errLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.setValue(nil, forKey: "Email")
            UserDefaults.standard.setValue(nil, forKey: "ID")
        }
        catch{
            print("already signed out")
            
        }
        print("login loaded")
        errLabel.alpha = 0
        // Do any additional setup after loading the view.
        
        //UI
        
        //Adding icon to text fields
        let IdImage = UIImage(named: "person")
        let tintedIdImage = IdImage?.withRenderingMode(.alwaysTemplate)
        addLeftImageTo(txtField: ID, andImage: tintedIdImage!)
        //ID.tintColor = .gray
        ID.alpha = 0.5
        
        let PasswordImage = UIImage(named: "lockgray")
        let tintedPasswordImage = PasswordImage?.withRenderingMode(.alwaysTemplate)
        addLeftImageTo(txtField: Password, andImage: tintedPasswordImage!)
        //Password.tintColor = .gray
        Password.alpha = 0.5
        //
    }
    
    //UI
    
    //function to add icon to left of text field
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        leftImageView.image = img.addImagePadding(x: 20, y: 10)
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }
    
    //
    
    private func checkAuth(enteredID: String, psw: String) {
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
                        UserDefaults.standard.set(enteredID, forKey: "ID")
                        UserDefaults.standard.synchronize()
                        
                        let initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Nav") as! Navig
                        
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
        
       
    }
    
    func showErr(description: String){
        
        errLabel.text = description
        errLabel.alpha = 1
    }
    
    func hideErr(){
        errLabel.alpha = 0
    }
    
    @IBAction func logIn(_ sender: Any) {
        
        guard let enteredID = ID.text else {
            print("Enter ID")
            showErr(description: "Enter ID")
            return
        }
        
        if let psw = Password.text {
            
        checkAuth(enteredID: enteredID, psw: psw)
        } else {
            showErr(description: "Enter Password")
            print("Enter Password")
        }
    }
    
}
