//
//  MSscheduleApp.swift
//  MSschedule
//
//  Created by 陳昱豪 on 2020/8/29.
//

import SwiftUI

@main
struct MSscheduleApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        
        WindowGroup {
            MotherView().environmentObject(ViewRouter())                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
