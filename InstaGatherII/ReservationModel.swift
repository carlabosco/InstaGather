//
//  ReservationModel.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 7/25/19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import Foundation

struct Restaurants:Decodable {
    var restaurants: [RestaurantInfo]
}

struct RestaurantInfo:Decodable {
    var name: String
    var address: String
    var city: String
    var mobile_reserve_url: String
}
