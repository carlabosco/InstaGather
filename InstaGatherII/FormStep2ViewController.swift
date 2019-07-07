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
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        
        dateField.inputView = datePicker
        
        datePicker?.addTarget(self, action: #selector(FormStep2ViewController.dateChanged(datePicker:)), for: .valueChanged)

    }
    
    var selectedDate = ""
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        dateField.text = dateFormatter.string(from: datePicker.date)
        selectedDate = dateField.text!
        
    }
    
    
    
    @IBAction func endDateSelection(_ sender: UIButton) {
        view.endEditing(true)
        print(selectedDate)
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
