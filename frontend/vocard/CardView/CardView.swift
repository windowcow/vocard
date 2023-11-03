//
//  CardView.swift
//  vocard
//
//  Created by windowcow on 10/29/23.
//

import SwiftUI

enum CardSide {
    case front, detail, quiz
}

struct CardView: View {
    @Binding var cardSide: CardSide
    @Namespace var namespace
    @State private var isCardDetailEditPresented: Bool = false
    
    var body: some View {
        switch cardSide {
        case .front:
            CardFrontView(cardData: .example)
                .draggable(cardSide: $cardSide)
        case .detail:
            CardDetailView(cardData: .example)
                .fullScreenCover(isPresented: $isCardDetailEditPresented) {
                    CardDetailEditView(cardData: .example)
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
    CardView(cardSide: Binding<CardSide>.constant(.detail))
}
