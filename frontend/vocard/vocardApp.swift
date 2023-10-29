//
//  vocardApp.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI
import SwiftData

@main
struct vocardApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            CardStudyView()
        }
        .modelContainer(sharedModelContainer)

    }
}
