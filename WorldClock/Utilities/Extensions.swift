//
//  Extensions.swift
//  WorldClock
//
//  Created by Shayan Mehranpoor on 1/7/18.
//  Copyright © 2018 mehranpoor. All rights reserved.
//

import Foundation
import AASquaresLoading
import SystemConfiguration

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
    
    func isConnectedToInternet() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func internetConnectionAlert() {
        let alertController = UIAlertController(title: "", message: "Please check internet connection", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Settings", style: .default) { UIAlertAction in
            if let url = URL(string: "App-Prefs:root=WIFI"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { UIAlertAction in
            print("cancel")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alertController, animated: true, completion: nil)
        }
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

