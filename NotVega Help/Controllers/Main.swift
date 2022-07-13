//
//  ViewController.swift
//  NotVega Help
//
//  Created by IACD-022 on 2022/06/20.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class Main: UIViewController {
    
    
    @IBOutlet var introText: UILabel!
    @IBOutlet var weeklyScheduleBtn: UIButton!
    @IBOutlet var yearCalendarBtn: UIButton!
    @IBOutlet var mapBtn: UIButton!
    @IBOutlet var clubBtn: UIButton!
    @IBOutlet var numbersText: UITextView!
    
    
    //values for UI
    let spacing: CGFloat = 15.0
    let imageSpacing: CGFloat = 20.0
    
    var window: UIWindow?
    private let db = Firestore.firestore()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Main")
        addDefaults()
    }
    
    func UIBuild(){
        //UI
        introText.text = "Welcome, \(getUserDefaults()?.name ?? "student")"
        
        weeklyScheduleBtn.setTitle("weekly\nschedule", for: .normal)
        weeklyScheduleBtn.configuration?.titlePadding = spacing
        weeklyScheduleBtn.configuration?.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        weeklyScheduleBtn.titleLabel?.font = weeklyScheduleBtn.titleLabel!.font.withSize(30)
        
        
        yearCalendarBtn.setTitle("year\ncalendar", for: .normal)
        yearCalendarBtn.configuration?.titlePadding = spacing
        yearCalendarBtn.configuration?.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        mapBtn.setTitle("campus\nmap", for: .normal)
        mapBtn.configuration?.titlePadding = spacing
        mapBtn.configuration?.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        clubBtn.setTitle("clubs", for: .normal)
        clubBtn.configuration?.titlePadding = spacing
        clubBtn.configuration?.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        numbersText.text = "+27 11 000 1234 \n+27 11 123 0000"
        numbersText.contentInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        //Shadows
        weeklyScheduleBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        weeklyScheduleBtn.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        weeklyScheduleBtn.layer.shadowOpacity = 0.2
        weeklyScheduleBtn.layer.shadowRadius = 1.0
        
        yearCalendarBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        yearCalendarBtn.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        yearCalendarBtn.layer.shadowOpacity = 0.2
        yearCalendarBtn.layer.shadowRadius = 1.0
        
        mapBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        mapBtn.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        mapBtn.layer.shadowOpacity = 0.2
        mapBtn.layer.shadowRadius = 1.0
        
        clubBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        clubBtn.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        clubBtn.layer.shadowOpacity = 0.2
        clubBtn.layer.shadowRadius = 1.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToClubs"{
            
        }
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
            self.UIBuild()
            self.introText.text = "Welcome, \(getUserDefaults()?.name ?? "student")"
        }
        
    } // function addDefault
    
} // class

