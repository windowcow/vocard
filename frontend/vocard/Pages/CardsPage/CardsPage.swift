//
//  CardsPage.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI

struct CardsPage: View {
    @State private var vm: CardsPage_VM = CardsPage_VM()
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
            VStack {
                CardsPage_Top()
                    .frame(maxHeight: 50)
                CardsPage_Middle_FilterSort()
                CardsPage_CardScroll()
            }
        }
        .environment(vm)
    }
}

#Preview {
    CardsPage()
        .modelContainer(sharedModelContainer)
}
