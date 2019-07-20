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
        
        let realmFile = try! Realm()
        let savedGroups = realmFile.objects(Group.self)
        print(savedGroups)
   
        
        let namesString = event?.guestsNames?.joined(separator: ", ")
       
        summaryField.text =
        "Event: \(event?.name ?? "party") \nWhere: \(event?.address ?? "home") \nWhen: \(event?.date ?? "today") \nGuests: \(namesString ?? "")"
        
        
        if (event?.guestsNames!.count)! > 1 {
            
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
                }
            }))
        
            self.present(alert, animated: true)
            
        }
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "Let's get together!\nEvent: \(event?.name ?? "") \nWhen: \(event?.date ?? "") \nWhere: \(event?.address ?? "")";
        messageVC.recipients = event?.guestsPhones
        messageVC.messageComposeDelegate = self
        self.present(messageVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case MessageComposeResult.cancelled:
            print("Message was cancelled")
            dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed:
            print("Message failed")
            dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent:
            print("Message was sent")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
}
