//
//  SwiftDataPractice2App.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 11/30/23.
//

import SwiftUI


@main
struct SwiftDataPractice2App: App {
    

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(sharedModelContainer)
    }
}
