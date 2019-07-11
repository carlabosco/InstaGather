//
//  Event.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 02.07.19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import UIKit
import ContactsUI

class Event: NSObject {
    var name: String?
    var date: String?
    var address: String?
    var guests: [[String:String]]?
    var guestsNames: [String]?
    var guestsPhones: [String]?
}
