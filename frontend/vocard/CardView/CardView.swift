//
//  CardView.swift
//  vocard
//
//  Created by windowcow on 10/29/23.
//

import SwiftUI

enum CardSide {
    case front, back
}

struct CardView: View {
    @State private var cardSide: CardSide = .front
    
    var body: some View {
        switch cardSide {
        case .front:
            CardFrontView(cardData: .example)
        case .back:
            CardDontKnowView'(cardData: .example)
        }
    }
}

#Preview {
    CardView()
}
