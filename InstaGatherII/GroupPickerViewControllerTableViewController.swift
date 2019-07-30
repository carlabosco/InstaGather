//
//  GroupPickerViewControllerTableViewController.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 7/16/19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import UIKit
import RealmSwift


class GroupPickerViewControllerTableViewController: UITableViewController {
  
    @IBAction func doneButton(_ sender: Any) {
        performSegue(withIdentifier: "BackFromSelectedGroups", sender: self)
    }
    
    var event: Event?
    var groups = try! Realm().objects(Group.self)
    var selectedGroups: [Group] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension GroupPickerViewControllerTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        let group = groups[indexPath.row]
        cell.textLabel?.text = group.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        selectedGroups.append(self.groups[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            let group = groups[indexPath.row]
            
            let realm = try! Realm()
            let stored = realm.objects(Group.self)
            
            try! realm.write {
                realm.delete(stored)
            }
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackFromSelectedGroups" {
            let step4VC = segue.destination as! FormStep4ViewController
            step4VC.selectedGroups = self.selectedGroups
        }
    }
}

