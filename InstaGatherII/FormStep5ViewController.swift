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
    var selectedGroups: [Group]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //    ************    Generate GoogleCalendar url  **********
        
//        let calendarURL = """
//        http://www.google.com/calendar/render?
//        action=TEMPLATE
//        &text="\(event!.name!)"
//        &dates=20200127T224000/20140320T221500
//        &location="\(event!.address!)"
//        &trp=false
//        &sprop=
//        &sprop=name:"
//        target="_blank" rel="nofollow"
//        """
//       print(URL(string: calendarURL)!)
        //        **************************************
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let realmFile = try! Realm()
        let savedGroups = realmFile.objects(Group.self)
        print(savedGroups)
        
   
        
        let namesString = event?.guestsNames?.joined(separator: ", ")
     
        summaryField.text = """
            Event: \(event?.name ?? "party") \n
            Where: \(event!.address!) \n
            Map: \(URL(string: "https://www.google.com/maps/search/?api=1&query=0&query_place_id=\(self.event!.placeID!)")!)\n
            When: \(event?.date ?? "today") \n
            Guests: \(namesString ?? "")
        """
        
        if (event?.guestsNames!.count)! > 1 && self.selectedGroups?.count == 0 {
            
            var groups = try! Realm().objects(Group.self)
            
            try! realmFile.write {
                realmFile.add(savedGroups)
//                realmFile.add(guests)
                realmFile.add(groups)
            }
            
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
                    
//                    try! realmFile.write {
//                        realmFile.add(newGroup)
//                    }
                    
                    try! realmFile.write {
                        _ = realmFile.create(Group.self, value: ["name": alert.textFields?.first?.text as Any, "groupContacts": self.event!.guests], update: false)
                    }
                }
            }))
        
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "Let's get together!\n\nEvent: \(event?.name ?? "party")\n\nWhen: \(event?.date ?? "today") \n\nWhere: \(event!.address!) \n\nOpen with GoogleMaps: \(URL(string: "https://www.google.com/maps/search/?api=1&query=0&query_place_id=\(event!.placeID!)")!) \n\nPlease RSVP by replying to this text.\n\nSent with InstaGather";
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
