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
    }
    
    func updateWorldClockList(timeZoneDetail: Zone) {
        self.cityNameLbl.text = timeZoneDetail.zoneName.sliceString(needle: "/", beforeNeedle: false)
        self.offsetLbl.text = secondsToHoursMinutes(seconds: timeZoneDetail.gmtOffset)
    }
}
