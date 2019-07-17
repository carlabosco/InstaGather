//
//  FormStep5ViewController.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 10.07.19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import UIKit
import MessageUI
import RealmSwift

class FormStep5ViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var summaryField: UITextView!
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
        let realmFile = try! Realm()
        let savedGroups = realmFile.objects(Group.self)
        print(savedGroups)
   
        
//        let realm = try! Realm()
        
        let namesString = event?.guestsNames?.joined(separator: ", ")
       
        summaryField.text =
        "Event: \(event?.name ?? "party") \nWhere: \(event?.address ?? "home") \nWhen: \(event?.date ?? "today") \nGuests: \(namesString ?? "")"
        
        let alert = UIAlertController(title: "Save guests as a group?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No, thank you.", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Group name"
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let groupName = alert.textFields?.first?.text {
                
                
                
                let newGroup = Group()
                
                newGroup.name = alert.textFields?.first?.text
                newGroup.groupContacts = self.event!.guests
                
                try! realmFile.write {
                    realmFile.add(newGroup)
                }
                
//                let gees = realm.objects(Group.self)
//                print (Array(gees))
                
                
                
//                print("Group name: \(newGroup)")
                
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    
    @IBAction func sendButtonAction(_ sender: Any) {
        
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "Let's get together!\nEvent: \(event?.name) \nDate: \(event?.date) \nAddress: \(event?.address)";
        messageVC.recipients = event?.guestsPhones
        messageVC.messageComposeDelegate = self
        self.present(messageVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
}
