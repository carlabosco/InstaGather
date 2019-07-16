//
//  Group.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 7/15/19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import Foundation
import RealmSwift

class Group: Object {
    @objc dynamic var name: String?
    var groupContacts = List<Contact>()
}
