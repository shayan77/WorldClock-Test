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
    
    @IBOutlet weak var worldClockTableView: UITableView!
    @IBOutlet weak var noTimezoneImage: UIImageView!
    @IBOutlet weak var noTimezoneLbl: UILabel!
    
    var timeZonesDetails = [Zone]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllerUtilities()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name:NSNotification.Name(rawValue: "reloadView"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func reloadView() {
        if isConnectedToInternet() {
            if zoneName != "" {
                squareLoading = initSquareLoading(view: view)
                getTimeZoneDetailList(zoneName: zoneName) { (result) -> () in
                    self.timeZonesDetails.append(contentsOf: result.zones)
                    self.timeZonesDetails.reverse()
                    self.worldClockTableView.reloadData()
                    self.checkExistingTimeZone()
                    squareLoading.stop()
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.internetConnectionAlert()
            })
        }
    }
    
    func viewControllerUtilities() {
        worldClockTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 12))
        worldClockTableView.delegate = self
        worldClockTableView.dataSource = self
        
        noTimezoneImage.isHidden = false
        noTimezoneLbl.isHidden = false
        worldClockTableView.isHidden = true
    }
    
    func checkExistingTimeZone() {
        self.worldClockTableView.isHidden = false
        self.noTimezoneImage.isHidden = true
        self.noTimezoneLbl.isHidden = true
        if timeZonesDetails.isEmpty {
            self.noTimezoneImage.isHidden = false
            self.noTimezoneLbl.isHidden = false
            self.worldClockTableView.isHidden = true
        }
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            self.timeZonesDetails.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.worldClockTableView.reloadData()
            self.checkExistingTimeZone()
        }
    }
}
