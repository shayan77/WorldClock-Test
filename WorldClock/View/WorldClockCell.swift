//
//  WorldClockCell.swift
//  WorldClock
//
//  Created by Shayan Mehranpoor on 1/6/18.
//  Copyright © 2018 mehranpoor. All rights reserved.
//

import UIKit

class WorldClockCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var offsetLbl: UILabel!
    @IBOutlet weak var analogClockView: BEMAnalogClockView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        analogClockInit()
    }
    
    func updateWorldClockList(timeZoneDetail: Zone) {
        self.cityNameLbl.text = timeZoneDetail.zoneName.sliceString(needle: "/", beforeNeedle: false)
        
        if 7 ..< 18 ~= convertTimestampToHour(timestamp: "\(timeZoneDetail.timestamp!)") {
            day()
            self.offsetLbl.text = "day  \(secondsToHoursMinutes(seconds: timeZoneDetail.gmtOffset))"
        } else {
            night()
            self.offsetLbl.text = "night  \(secondsToHoursMinutes(seconds: timeZoneDetail.gmtOffset))"
        }
        self.analogClockView.hours = convertTimestampToHour(timestamp: "\(timeZoneDetail.timestamp!)")
        self.analogClockView.minutes = convertTimestampToMinute(timestamp: "\(timeZoneDetail.timestamp!)")
        self.analogClockView.seconds = convertTimestampToSecond(timestamp: "\(timeZoneDetail.timestamp!)")
    }
    
    func day() {
        analogClockView.borderWidth = 0.0
        analogClockView.digitColor = UIColor.black
        analogClockView.faceBackgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        analogClockView.hourHandColor = UIColor.black
        analogClockView.minuteHandColor = UIColor.black
        analogClockView.secondHandColor = UIColor.black
        analogClockView.hubColor = UIColor.black
    }
    
    func night() {
        analogClockView.borderWidth = 0.0
        analogClockView.digitColor = UIColor.white
        analogClockView.faceBackgroundColor = UIColor.black
        analogClockView.hourHandColor = UIColor.white
        analogClockView.minuteHandColor = UIColor.white
        analogClockView.secondHandColor = UIColor.white
        analogClockView.hubColor = UIColor.white
    }
    
    func analogClockInit() {
        analogClockView.realTime = true
        analogClockView.enableDigit = true
        analogClockView.enableGraduations = false
        analogClockView.hourHandWidth = 1.5
        analogClockView.minuteHandWidth = 1.5
        analogClockView.hourHandLength = 22
        analogClockView.minuteHandLength = 30
        analogClockView.secondHandLength = 35
        analogClockView.digitOffset = 16.0
        analogClockView.digitFont = UIFont(name: analogClockView.digitFont.fontName, size: 10.0)
    }
}
