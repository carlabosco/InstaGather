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
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let realm = try! Realm()
       
        summaryField.text = "Event: \(event?.name ?? "party") \nWhere: \(event?.address ?? "home") \nWhen: \(event?.date ?? "today") \nGuests: \(event?.guestsNames ?? [""])"
        
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
                
                try! realm.write {
                    realm.add(newGroup)
                }
                
                print("Group name: \(newGroup)")
                
                for contact in newGroup.groupContacts {
                    print(contact.fullName)
                }
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
