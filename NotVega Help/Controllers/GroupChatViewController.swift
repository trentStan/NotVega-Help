//
//  GroupChatViewController.swift
//  NotVega Help
//
//  Created by IACD-019 on 2022/07/13.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class GroupChatViewController: UIViewController {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextField: UITextField!
    
    private let db = Firestore.firestore()
    var messages: [Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chatTableView.dataSource = self
        
        chatTableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
        
        loadMessages()
    }
    
    func loadMessages() {
        
        db.collection("Messages").addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
            if let e = error {
                print("Could not retrieve Message Information from Firestore: \(e)")
            } else {
                if let snapshotDocument = querySnapshot?.documents {
                    for doc in snapshotDocument {
                        let data = doc.data()
                        if let messageSender = data["sender"] as? String, let messageBody = data["body"] as? String {
                            let newMessage = Message(sender: messageSender, message: messageBody)
                            self.messages.append(newMessage)
                        }
                    }
                }
            }
            
            
        }
    }
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        
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

extension GroupChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row].message
        return cell
    }
    
    
}
