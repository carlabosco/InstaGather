//
//  FormStep2ViewController.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 02.07.19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import UIKit

class FormStep2ViewController: UIViewController {
    
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    private var datePicker: UIDatePicker?
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        
        dateField.inputView = datePicker
        
        datePicker?.addTarget(self, action: #selector(FormStep2ViewController.dateChanged(datePicker:)), for: .valueChanged)

    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        dateField.text = dateFormatter.string(from: datePicker.date)

        
    }
    
    @IBAction func endDateSelection(_ sender: UIButton) {
        view.endEditing(true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.event?.date = dateField.text
        let step3VC = segue.destination as! FormStep3ViewController
        step3VC.event = self.event
    }


}
