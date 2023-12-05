//
//  CardsPage_Top.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI

struct CardsPage_Top: View {
    @Environment(CardsPage_VM.self) var vm
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CardsPage()
        .modelContainer(sharedModelContainer)
}
