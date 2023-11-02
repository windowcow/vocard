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
    @State private var cardSide: CardSide = .front
    
    var body: some View {
        GeometryReader { geo in
            switch cardSide {
            case .front:
                CardFrontView(cardData: .example)
                    .draggable(cardSide: $cardSide)
            case .detail:
                CardDetailView(cardData: .example)
                    .onLongPressGesture {
                        withAnimation(.spring) {
                            cardSide = .detailEdit
                        }
                    }
            case .detailEdit:
                CardDetailEditView(cardData: .example)
            case .quiz:
                VStack {
                    CardQuizView(quiz: Quiz.example)
                    
                    CardQuizBottomButtonView()
                }
            }
        }
        
    }
}

#Preview {
    CardView()
}
