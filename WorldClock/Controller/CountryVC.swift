//
//  CountryVC.swift
//  WorldClock
//
//  Created by Shayan Mehranpoor on 1/6/18.
//  Copyright © 2018 mehranpoor. All rights reserved.
//

import UIKit
import ObjectMapper

class CountryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var timeZones = [RegionTimeZone]()
    var filteredTimeZones = [RegionTimeZone]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllerUtilities()
        
        if let path = Bundle.main.path(forResource: "Countries", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                timeZones = Mapper<RegionTimeZone>().mapArray(JSONArray: jsonResult as! [[String : Any]])
                filteredTimeZones = timeZones
                self.countryTableView.reloadData()
            } catch {
                print("error")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func viewControllerUtilities() {
        countryTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 12))
        countryTableView.delegate = self
        countryTableView.dataSource = self
        searchBar.delegate = self
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
        return filteredTimeZones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell {
            let timeZone = filteredTimeZones[indexPath.row]
            cell.updateTimeZoneList(timeZone: timeZone)
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        zoneName = self.filteredTimeZones[indexPath.row].zoneName
        if UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadView"), object: nil)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
            return 75
        } else {
            return 60
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTimeZones = searchText.isEmpty ? timeZones : timeZones.filter { (item: RegionTimeZone) -> Bool in
            return (item.countryName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil) || (item.zoneName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil)
        }
        
        countryTableView.reloadData()
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        zoneName = ""
        dismiss(animated: true, completion: nil)
    }
}
