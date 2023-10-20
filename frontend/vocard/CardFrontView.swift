//
//  CardFrontView.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI

struct CardFrontView: View {
    @State var cardData: CardData
    
    var body: some View {
        VStack {
            Text("SCORE: \(cardData.learningScore)")
        }
        .scaledToFit()
        .background(.green, in: CardShape())
    }
}

#Preview {
    ZStack {
        CardFrontView(cardData:
            CardData(
                originalWord: "사과",
                translatedWord: "apple",
                englishDefinition: "a round fruit with red, yellow, or green skin and firm white flesh",
                exampleSentence: "She ate a fresh apple for breakfast.",
                learningScore: 5,
                consecutiveCorrectStreak: 3
            )
        )
    }
    
}
