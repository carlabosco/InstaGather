//
//  Contact.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 7/15/19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import Foundation
import RealmSwift

class Contact: Object {
    @objc dynamic var fullName: String?
    @objc dynamic var phoneNumber: String?
}
