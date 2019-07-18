//
//  Event.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 02.07.19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import UIKit
import ContactsUI
import RealmSwift

class Event: Object {
    @objc dynamic var name: String?
    @objc dynamic var date: String?
    @objc dynamic var address: String?
    var guests = List<Contact>()
    var guestsNames: [String]?
    var guestsPhones: [String]?
}
