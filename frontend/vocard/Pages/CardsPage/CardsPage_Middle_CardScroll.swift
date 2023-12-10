//
//  CardPage.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI
import SwiftData



struct CardsPage_Middle_CardScroll: View {
    let gridItem2: [GridItem] = [
        GridItem(.flexible(), alignment: nil),
        GridItem(.flexible(),  alignment: nil)

    ]
    let gridItem3: [GridItem] = [
        GridItem(.flexible(), alignment: nil),
        GridItem(.flexible(),  alignment: nil),
        GridItem(.flexible(),  alignment: nil)

    ]
    
    @Environment(CardsPage_VM.self) private var vm
    
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: vm.columnNum == 2 ? gridItem2 : gridItem3,
                      alignment: .center, spacing: 20) {
                ForEach(vm.cards) { card in
                    CardsPage_Middle_CardView(card: card)
                }
            }
                     
        }
        .padding(.horizontal)
        .animation(.bouncy, value: vm.cards)
    }
}

#Preview {
    CardsPage()
        .background(.white)
        .modelContainer(sharedModelContainer)
}
