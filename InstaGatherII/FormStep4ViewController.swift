//
//  FormStep4ViewController.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 08.07.19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI


class FormStep4ViewController: UIViewController, CNContactPickerDelegate {
    
    @IBOutlet weak var whosComingLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    var event: Event?
    var guestList = [[String:String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(event!.name)
//        print(event!.date)
//        print(event!.address)

    }
    
    @IBAction func selectContacts(_ sender: Any) {
        
        let entityType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entityType)
        
        if authStatus == CNAuthorizationStatus.notDetermined {
            
            let contactStore = CNContactStore.init()
            contactStore.requestAccess(for: entityType, completionHandler: {(success, nil) in
                if success {
                    self.openContacts()
                }
                else {
                    print("Not authorized")
                }
            })
        }
        else if authStatus == CNAuthorizationStatus.authorized {
            self.openContacts()
        }
    }
    
        func openContacts() {
            let contactPicker = CNContactPickerViewController.init()
            contactPicker.delegate = self as?  CNContactPickerDelegate
            self.present(contactPicker, animated: true, completion: nil)
        }
    
        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            picker.dismiss(animated: true)
        }
    
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
            for contact in contacts {
                
                let phoneString = ((((contact.phoneNumbers[0] as AnyObject).value(forKey: "labelValuePair") as AnyObject).value(forKey: "value") as AnyObject).value(forKey: "stringValue"))
                
                let guest = [
                    "fullName": "\(contact.givenName) \(contact.familyName)",
                    "phoneNumber": phoneString! as! String
                ]
                guestList.append(guest)
                print(guestList)
            }
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.event?.guests = guestList
        let step5VC = segue.destination as! FormStep5ViewController
        step5VC.event = self.event
    }
    
    }
    

