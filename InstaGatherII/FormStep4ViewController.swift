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
import RealmSwift


class FormStep4ViewController: UIViewController, CNContactPickerDelegate {
    
    @IBOutlet weak var whosComingLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var selectGroupButton: UIButton!
    
    let realm = try! Realm()
    var contacts = try! Realm().objects(Contact.self)
    
    var event: Event?
    var guests = List<Contact>()
    var guestsNames = [String]()
    var guestsPhones = [String]()
    
    var selectedGroups: [Group] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contacts = realm.objects(Contact.self)
    }
    
    @IBAction func unwindToFormStep4(_ unwindSegue: UIStoryboardSegue) {
         print("Entered unwind function +++++++++++++++++++++++++\(selectedGroups)")
//        var selectedGroups: [Group] = []
        if let sourceViewController = unwindSegue.source as? GroupPickerViewControllerTableViewController {
            selectedGroups = sourceViewController.selectedGroups
        }
        
        for group in selectedGroups {
            for contact in group.groupContacts {
                
//                try! realm.write {
                    guestsNames.append(contact.fullName!)
                    guestsPhones.append(contact.phoneNumber!)
//                    realm.add(contact)
//                }
            }
        }
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
            
            print("Entered contactPicker function *******************\(selectedGroups)")
            
            var guests = List<Contact>()
            let realm = try! Realm()
//            var contacts = try! Realm().objects(Contact.self)
            try! realm.write {
                realm.add(selectedGroups)
                realm.add(guests)
            }

            
                for contact in contacts {
                
                let newContact = Contact()
//                realm.add(newContact)
                
                newContact.fullName = "\(contact.givenName) \(contact.familyName)"
                
                let phoneString = ((((contact.phoneNumbers[0] as AnyObject).value(forKey: "labelValuePair") as AnyObject).value(forKey: "value") as AnyObject).value(forKey: "stringValue"))
                
                newContact.phoneNumber = (phoneString! as! String)
                let fullName = "\(contact.givenName) \(contact.familyName)"
                guestsNames.append(fullName)
                guestsPhones.append(phoneString! as! String)
                
                    let realm = try! Realm()
//                    var contacts = try! Realm().objects(Contact.self)
                    try! realm.write {
                        guests.append(newContact)
                        realm.add(guests)
                    }
                
//                guests.append(newContact)
                print("added contact ***************************************\(newContact) added")
//                    print(self.event!.isInvalidated)
                print("***************************************\(guests)")
            }
        }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Entered segue")
//        print(guests.isInvalidated)
        
        if (segue.identifier == "FormStep5ViewController") {
//            print(guests.isInvalidated)
            self.event?.guests = guests
            self.event?.guestsNames = guestsNames
            self.event?.guestsPhones = guestsPhones
            let step5VC = segue.destination as! FormStep5ViewController
            step5VC.event = self.event
            
        }
        if (segue.identifier == "PickGroup") {
            self.event?.guests = guests
            self.event?.guestsNames = guestsNames
            self.event?.guestsPhones = guestsPhones
            let pickGroupVC = segue.destination as! GroupPickerViewControllerTableViewController
            pickGroupVC.event = self.event
        }
    }
}
    

