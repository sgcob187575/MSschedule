//
//  Appdelegate.swift
//  MSschedule
//
//  Created by 陳昱豪 on 2020/8/29.
//

import Foundation
import SwiftUI
import GoogleMaps
class AppDelegate: NSObject, UIApplicationDelegate {
    let googleApiKey = "AIzaSyCSWiVBrZtonDveBgZ4Q0q7sDZftgQV_a8"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(googleApiKey)
        return true
    }
    
}
