//
//  Extensions.swift
//  WorldClock
//
//  Created by Shayan Mehranpoor on 1/7/18.
//  Copyright © 2018 mehranpoor. All rights reserved.
//

import Foundation
import AASquaresLoading

extension UIViewController {
    func initSquareLoading(view: UIView) -> AASquaresLoading {
        var loadingSquare = AASquaresLoading()
        if UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
            loadingSquare = AASquaresLoading(target: view, size: 100.0)
        } else {
            loadingSquare = AASquaresLoading(target: view, size: 50.0)
        }
        loadingSquare.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        loadingSquare.color = self.view.tintColor
        
        loadingSquare.start()
        
        return loadingSquare
    }
}

extension UITableViewCell {
    func secondsToHoursMinutes (seconds : Int64) -> String {
        return "\(seconds / 3600):\((seconds % 3600) / 60) hrs"
    }
    
    func convertTimestampToTime(timestamp: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(Double(timestamp)!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func convertTimestampToHour(timestamp: String) -> Int {
        let date = Date(timeIntervalSince1970: TimeInterval(Double(timestamp)!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let localDate = dateFormatter.string(from: date)
        return Int(localDate)!
    }
    
    func convertTimestampToMinute(timestamp: String) -> Int {
        let date = Date(timeIntervalSince1970: TimeInterval(Double(timestamp)!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let localDate = dateFormatter.string(from: date)
        return Int(localDate)!
    }
    
    func convertTimestampToSecond(timestamp: String) -> Int {
        let date = Date(timeIntervalSince1970: TimeInterval(Double(timestamp)!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let localDate = dateFormatter.string(from: date)
        return Int(localDate)!
    }
}

extension String {
    
    func sliceString(needle: String, beforeNeedle: Bool) -> String? {
        guard let range = self.range(of: needle) else { return nil }
        
        if beforeNeedle {
            return String(self[startIndex..<range.lowerBound])
        }
        
        return String(self[range.upperBound ..< endIndex])
    }
    
}

