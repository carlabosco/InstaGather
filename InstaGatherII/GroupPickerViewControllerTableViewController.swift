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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(groups)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
}
