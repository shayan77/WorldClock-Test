//
//  TimeZones.swift
//  WorldClock
//
//  Created by Shayan Mehranpoor on 1/6/18.
//  Copyright © 2018 mehranpoor. All rights reserved.
//

import Foundation
import ObjectMapper

class RegionTimeZone: Mappable {
    
    var countryCode: String!
    var countryName: String!
    var zoneName: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        countryCode <- map["countryCode"]
        countryName <- map["countryName"]
        zoneName <- map["zoneName"]
    }
}
