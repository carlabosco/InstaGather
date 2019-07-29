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
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let realmFile = try! Realm()
        let savedGroups = realmFile.objects(Group.self)
        print(savedGroups)
        
   
        
        let namesString = event?.guestsNames?.joined(separator: ", ")
     
        summaryField.text = """
            Event: \(event?.name ?? "party") \n
            When: \(event?.date ?? "today") \n
            Where: \(event!.address!) \n
            Open with GoogleMaps: \(URL(string: "https://www.google.com/maps/search/?api=1&query=0&query_place_id=\(self.event!.placeID!)")!)\n
            Guests: \(namesString ?? "")
        """
        
//        let boldedWords = ["Event:", "When:", "Where:", "Open with GoogleMaps", "Guests:"]
//        let text: NSString = summaryField?.text as! NSString
//        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text as String)
//        
//        for word in boldedWords {
//            attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], range: text.range(of: word))
//        }
//        
//        summaryField.attributedText = attributedText
        
        
        
        if (event?.guestsNames!.count)! > 1 && self.selectedGroups?.count == 0 {
            
            var groups = try! Realm().objects(Group.self)
            
            try! realmFile.write {
                realmFile.add(savedGroups)
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
        messageVC.body = """
            Let's get together!\n\n
            Event: \(event?.name ?? "party")\n\n
            When: \(event?.date ?? "today") \n\n
            Where: \(event!.address!) \n\n
            Open with GoogleMaps: \(URL(string: "https://www.google.com/maps/search/?api=1&query=0&query_place_id=\(event!.placeID!)")!) \n\n
            Please RSVP by replying to this text.\n\n
            Sent with InstaGather
        """;
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GoToReservation") {
            let reservationVC = segue.destination as! ReservationTableViewController
            reservationVC.event = self.event
        }
    }
}

