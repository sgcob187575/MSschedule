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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
