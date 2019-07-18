//
//  FormStep3ViewController.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 07.07.19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import UIKit

class FormStep3ViewController: UIViewController {
    
    @IBOutlet weak var addressField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var event: Event?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.event?.address = addressField.text
        let step4VC = segue.destination as! FormStep4ViewController
        step4VC.event = self.event
    }
}
