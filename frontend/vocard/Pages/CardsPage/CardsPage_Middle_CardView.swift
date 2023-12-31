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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.clear
            VStack {
                (
                Text(card.wordData.headword)
                    .bold()
                + Text("\(card.wordData.senseNum)")
                    .font(.caption2)
                    .baselineOffset(5)
                
                )
            }
            

        }
//        .background(.gray.gradient)
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
        .padding(1)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 1)
        }
        .padding(1)
        .onTapGesture {
            isCardsPage_CardView_Detail_Presented.toggle()
        }
        .fullScreenCover(isPresented: $isCardsPage_CardView_Detail_Presented) {
            CardDetailPage(headword: card.wordData.headword)
        }
    }
}


#Preview {
    CardsPage()
        .modelContainer(sharedModelContainer)
}
