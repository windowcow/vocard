//
//  CardsPage_Middle_CardView.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI

struct CardsPage_Middle_CardView: View {
    @Bindable var card: CardData
    @State private var isCardsPage_CardView_Detail_Presented = false
    
    var body: some View {
        ZStack {
            Color.clear
            Text(card.wordData.headWord)
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
        .contentShape(.rect)
        .onTapGesture {
            isCardsPage_CardView_Detail_Presented.toggle()
        }
        .fullScreenCover(isPresented: $isCardsPage_CardView_Detail_Presented) {
            CardDetailEditPage(card: card)
        }
    }
}


#Preview {
    CardsPage()
        .modelContainer(sharedModelContainer)
}
