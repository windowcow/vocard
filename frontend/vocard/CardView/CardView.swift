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
    @State private var cardSide: CardSide = .front
    
    var body: some View {
        switch cardSide {
        case .front:
            CardFrontView(cardData: .example)
                .draggable(cardSide: $cardSide)
        case .detail:
            CardDetailView(cardData: .example)
        case .quiz:
            CardQuizView(quiz: Quiz.example)
        }
    }
}

#Preview {
    CardView()
}
