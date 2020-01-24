//
//  ServiceResponse.swift
//  TestCherryPick
//
//  Created by Seif Nasri on 24/01/2020.
//  Copyright © 2020 Seif Nasri. All rights reserved.
//

import Foundation

struct ServiceResult : Codable{
    var results : [Result]
}


struct Result : Codable {
    var name : Name
    var location: Location
    var picture : Picture
}
