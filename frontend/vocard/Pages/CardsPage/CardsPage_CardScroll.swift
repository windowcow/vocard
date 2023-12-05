//
//  CardPage.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI
import SwiftData

struct CardsPage_CardView: View {
    @Bindable var card: CardDataModel
    
    var body: some View {
        ZStack {
            Color.clear
            Text(card.targetWordDataModel.headWord)
                .foregroundStyle(.white)

        }
        .background(.gray.gradient)
        .clipShape(.rect(cornerRadius: 15))
        .aspectRatio(0.66, contentMode: .fit)
        .overlay {
            VStack {
                StarView(starCount: card.currentStarCount ?? .zero)
                    .font(.caption)
                    .foregroundStyle(.yellow)
                    .padding(.top)
                Spacer()
            }
        }
    }
}

struct CardsPage_CardScroll: View {
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
                ForEach(vm.cards, id: \.persistentModelID) { card in
                    CardsPage_CardView(card: card)
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
