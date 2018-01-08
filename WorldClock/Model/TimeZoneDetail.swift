//
//  TimeZoneDetail.swift
//  WorldClock
//
//  Created by Shayan Mehranpoor on 1/6/18.
//  Copyright © 2018 mehranpoor. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class TimeZoneDetail: Mappable {
    
    var status: String!
    var message: String!
    var zones: [Zone]!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        zones <- map["zones"]
    }
}

class Zone: Mappable {
    
    var countryCode: String!
    var countryName: String!
    var zoneName: String!
    var gmtOffset: Int64!
    var timestamp: Int64!
    var hour: Int64!
    var minute: Int64!
    var second: Int64!
    
    required init?(map: Map) {
        
    }
    
    init() {
        newTimeZone()
    }
    
    func newTimeZone() {
        countryCode = "IR"
        countryName = "Iran"
        zoneName = "Asia/Tehran"
        hour = 0
        minute = 0
    }
    
    func mapping(map: Map) {
        countryCode <- map["countryCode"]
        countryName <- map["countryName"]
        zoneName <- map["zoneName"]
        gmtOffset <- map["gmtOffset"]
        timestamp <- map["timestamp"]
    }
    
    func secondsToHoursMinutes() -> String {
        hour = gmtOffset / 3600
        minute = (gmtOffset % 3600) / 60
        return "\(gmtOffset / 3600):\((gmtOffset % 3600) / 60) hrs"
    }
    
    func convertTimestampToHour() -> Int {
        let date = Date(timeIntervalSince1970: TimeInterval(Double(timestamp)))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let localDate = dateFormatter.string(from: date)
        hour = Int64(localDate)!
        return Int(localDate)!
    }
    
    func convertTimestampToMinute() -> Int {
        let date = Date(timeIntervalSince1970: TimeInterval(Double(timestamp)))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let localDate = dateFormatter.string(from: date)
        minute = Int64(localDate)!
        return Int(localDate)!
    }
    
    func convertTimestampToSecond() -> Int {
        let date = Date(timeIntervalSince1970: TimeInterval(Double(timestamp)))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let localDate = dateFormatter.string(from: date)
        second = Int64(localDate)!
        return Int(localDate)!
    }
}

func getTimeZoneDetailList(zoneName: String, success: @escaping (_ result: TimeZoneDetail) -> ()) {
    let URL = "\(baseUrl)?key=\(apiKey)&format=json&zone=\(zoneName)"
    
    Alamofire.request(URL, method: .get, encoding: JSONEncoding.default).responseObject { (response: DataResponse<TimeZoneDetail>) in
        let getTimeZoneDetailList = response.result.value
        switch response.result {
        case .success:
            success(getTimeZoneDetailList!)
        case .failure(let error):
            print(error)
        }
    }
}
