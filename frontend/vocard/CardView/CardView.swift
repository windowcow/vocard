//
//  CardView.swift
//  vocard
//
//  Created by windowcow on 10/29/23.
//

import SwiftUI

enum CardSide {
    case front, detail, quiz, detailEdit
}

struct CardView: View {
    @Binding  var cardSide: CardSide
    @Namespace var namespace
    
    var body: some View {
        GeometryReader { geo in
            switch cardSide {
            case .front:
                CardFrontView(cardData: .example)
                    .draggable(cardSide: $cardSide)
                    .matchedGeometryEffect(id: "card",
                                           in: namespace)
            case .detail:
                CardDetailView(cardData: .example)
                    .onLongPressGesture {
                        withAnimation(.spring) {
                            cardSide = .detailEdit
                        }
                    }
                    .matchedGeometryEffect(id: "card",
                                           in: namespace)

            case .detailEdit:
                CardDetailEditView(cardData: .example)
            case .quiz:
                CardQuizView(quiz: Quiz.example)
                    .matchedGeometryEffect(id: "card",
                                           in: namespace)

                    
            }
        }
    }
}

#Preview {
    CardView(cardSide: Binding<CardSide>.constant(.detail))
}
