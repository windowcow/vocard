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
        
        Text("Hello, World!")
    }
}

#Preview {
    let cardData: CardData = CardData(
        originalWord: "사과",
        translatedWord: "apple",
        englishDefinition: "a round fruit with red, yellow, or green skin and firm white flesh",
        exampleSentence: "She ate a fresh apple for breakfast.",
        learningScore: 5,
        consecutiveCorrectStreak: 3
    )

    CardFrontView(cardData: cardData)
}
