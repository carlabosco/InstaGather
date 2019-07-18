//
//  FormStep1ViewController.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 02.07.19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import UIKit

class FormStep1ViewController: UIViewController {

    
    @IBOutlet weak var eventFieldLabel: UILabel!
    @IBOutlet weak var eventField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.event = Event()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.event?.name = eventField.text
        let step2VC = segue.destination as! FormStep2ViewController
        step2VC.event = self.event
    }
}
