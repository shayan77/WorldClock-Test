//
//  CountryCell.swift
//  WorldClock
//
//  Created by Shayan Mehranpoor on 1/6/18.
//  Copyright © 2018 mehranpoor. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    
    @IBOutlet weak var zoneNameLbl: UILabel!
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var countryCodeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateTimeZoneList(timeZone: TimeZone) {
        self.zoneNameLbl.text = timeZone.zoneName
        self.countryNameLbl.text = timeZone.countryName
        self.countryCodeLbl.text = timeZone.countryCode
    }
}
