//
//  CardFrontView.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI

struct CardFrontView: View {
    let cardData: CardData
    
    var body: some View {
        ZStack {
            CardFrontBackgroundView(backgroundColor: Color.cardFront)
            CardWordTextView(cardData: cardData, cardType: .front)
        }
    }
}

#Preview {
    ZStack {
        CardFrontView(cardData: .example1)
            .draggable(cardSide: Binding<CardSide>.constant(CardSide.front))
    }
}
