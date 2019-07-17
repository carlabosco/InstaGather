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
    var event: Event?
    
    var groups = try! Realm().objects(Group.self)
    var selectedGroups: [Group] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(groups)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    
}

extension GroupPickerViewControllerTableViewController {
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)

        let group = groups[indexPath.row]
        cell.textLabel?.text = group.name
        
        

//        for contact in group.groupContacts {
//            cell.textLabel?.text = contact.fullName
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        print(self.groups[indexPath.row])
        
        selectedGroups.append(self.groups[indexPath.row])
        print(selectedGroups)
        
//        self.performSegue(withIdentifier: "backFromSelectedGroups", sender: nil)
    }
}

