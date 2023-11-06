//
//  CardView.swift
//  vocard
//
//  Created by windowcow on 10/29/23.
//

import SwiftUI


struct CardStudyPageMiddle: View {
    @Binding var cardSide: CardSide
    @Namespace var namespace
    @State private var isCardDetailEditPresented: Bool = false
    
    var body: some View {
        switch cardSide {
        case .front:
            CardFrontView(cardData: .example1)
                .cardDragModifier(cardSide: $cardSide)
        case .detail:
            CardDetailView(cardData: .example1)
                .fullScreenCover(isPresented: $isCardDetailEditPresented) {
                    CardDetailEditView(cardData: .example1)
                }
                .onLongPressGesture {
                    withAnimation(.spring) {
                        isCardDetailEditPresented.toggle()
                    }
                }
        case .quiz:
            CardQuizView(quiz: Quiz.example)
        }
    }
}

#Preview {
    CardStudyPageMiddle(cardSide: Binding<CardSide>.constant(.detail))
}
