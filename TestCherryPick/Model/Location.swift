//
//  Location.swift
//  TestCherryPick
//
//  Created by Seif Nasri on 24/01/2020.
//  Copyright © 2020 Seif Nasri. All rights reserved.
//

import Foundation
struct Location : Codable{
    var city:   String
    var state: String
    var country: String
    var postcode: Int
    var timezone : TimeZone
}



struct TimeZone : Codable {
    var offset: String
    var description: String
}
