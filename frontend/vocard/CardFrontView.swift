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
        GeometryReader { geo in
            VStack {
                Spacer()

                HStack {
                    Spacer()
                    
                    Text("SCORE  **\(cardData.learningScore)**")
                        .font(.title3)
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()

                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()

                Text("\(cardData.originalWord)")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()


            }
            
        }
        .background(Color("CardFrontColor") , in: CardShape())

        
    }
}

#Preview {
    ZStack {
        CardFrontView(cardData:
            CardData(
                originalWord: "apple",
                translatedWord: "사과",
                englishDefinition: "a round fruit with red, yellow, or green skin and firm white flesh",
                exampleSentence: "She ate a fresh apple for breakfast.",
                learningScore: 5,
                consecutiveCorrectStreak: 3
            )
        )
        .padding()
    }
}
