//
//  ChatViewController.swift
//  NotVega Help
//
//  Created by IACD-019 on 2022/07/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class ChatViewController: UIViewController {
    
    private let db = Firestore.firestore()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
        
        loadMessages()
    }
    
    func loadMessages() {
        
        db.collection("Messages").order(by: "date").addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
            if let e = error {
                print("Could not retrieve messages from Firestore: \(e)")
            } else {
                if let snapshotDocument = querySnapshot?.documents {
                    for doc in snapshotDocument {
                        let data = doc.data()
                        if let sender = data["sender"] as? String, let body = data["body"] as? String {
                            let newMessage = Message(sender: sender, message: body)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection("Messages").addDocument(data: ["sender": messageSender,
                                                         "body": messageBody,
                                                         "date": Date().timeIntervalSince1970
                                                        ]
            ) { error in
                if let e = error {
                    print("There was an issues adding message to Firestore: \(e)")
                } else {
                    print("Successfully saved message")
                    
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! MessageCell
        cell.messageLabel.text = message.message
        
        // Message from current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.senderName.text = "Me"
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.senderName.text = message.sender
        }
        return cell
    }
}
