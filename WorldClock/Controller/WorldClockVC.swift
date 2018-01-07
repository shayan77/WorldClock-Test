//
//  WorldClockVC.swift
//  WorldClock
//
//  Created by Shayan Mehranpoor on 1/6/18.
//  Copyright © 2018 mehranpoor. All rights reserved.
//

import UIKit
import ObjectMapper

class WorldClockVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var worldClickTableView: UITableView!
    
    var timeZonesDetails = [Zone]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllerUtilities()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if zoneName != "" {
            squareLoading = initSquareLoading(view: view)
            getTimeZoneDetailList(zoneName: zoneName) { (result) -> () in
                print(result.zones[0].timestamp)
                self.timeZonesDetails.append(contentsOf: result.zones)
                self.worldClickTableView.reloadData()
                squareLoading.stop()
            }
        }
    }
    
    func viewControllerUtilities() {
        worldClickTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 12))
        worldClickTableView.delegate = self
        worldClickTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }, completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZonesDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WorldClockCell", for: indexPath) as? WorldClockCell {
            let timeZoneDetail = timeZonesDetails[indexPath.row]
            cell.updateWorldClockList(timeZoneDetail: timeZoneDetail)
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
            return 220
        } else {
            return 110
        }
    }
}
