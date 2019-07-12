//
//  FormStep5ViewController.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 10.07.19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import UIKit
import MessageUI

class FormStep5ViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var summaryField: UITextView!
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        summaryField.text = "\(event?.name ?? "party") \(event?.address ?? "home") \(event?.date ?? "today") \(event?.guestsNames)"
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
