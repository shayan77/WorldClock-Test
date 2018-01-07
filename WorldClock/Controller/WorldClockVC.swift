//
//  WorldClockVC.swift
//  WorldClock
//
//  Created by Shayan Mehranpoor on 1/6/18.
//  Copyright © 2018 mehranpoor. All rights reserved.
//

import UIKit
import ObjectMapper

class WorldClockVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if zoneName != "" {
            getTimeZoneDetailList(zoneName: zoneName) { (result) -> () in
                print(result.zones.count)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(zoneName)
    }
}
