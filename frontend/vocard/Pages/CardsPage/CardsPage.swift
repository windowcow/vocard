//
//  CardsPage.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI
import SwiftData

struct CardsPage: View {
    @Query var allCards: [CardData]
    @State private var vm: CardsPage_VM = CardsPage_VM()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
            VStack {
                CardsPage_Top()
                    .frame(maxHeight: 50)
                CardsPage_Middle_FilterSort()
                CardsPage_Middle_CardScroll()
            }
        }
        .environment(vm)
        .task {
            vm.allCards = allCards
        }
    }
}

#Preview {
    CardsPage()
        .modelContainer(sharedModelContainer)
}
