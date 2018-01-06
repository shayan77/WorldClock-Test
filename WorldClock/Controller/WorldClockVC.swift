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
    
    var countries = [TimeZone]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTimeZoneDetailList(countryCode: "IR") { (result) -> () in
            print(result.zones[0].countryName)
        }
        
        if let path = Bundle.main.path(forResource: "Countries", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                countries = Mapper<TimeZone>().mapArray(JSONArray: jsonResult as! [[String : Any]])
                print(countries[10].countryName)
            } catch {
                print("error")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
