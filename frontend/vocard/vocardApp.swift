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

    var body: some Scene {
        WindowGroup {
//            CardPage()
//                .environment(CardPageViewModel())
            MainPage()
        }
        .modelContainer(sampleContainer)
    }
}
