//
//  FormStep5ViewController.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 10.07.19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import UIKit

class FormStep5ViewController: UIViewController {
    
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var summaryField: UITextView!
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
//        summaryField.text = "\(event?.name ?? "party") \(event?.address ?? "home") \(event?.date ?? "today") \(event?.guests)"
    }

}
