//
//  CardBackView.swift
//  vocard
//
//  Created by windowcow on 10/27/23.
//

import SwiftUI

struct CardBackView: View {
    @State var cardData: CardData
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()

                HStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("SCORE  **\(cardData.learningScore)**")
                        .font(.title3)
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
                
                
                Text("\(cardData.englishDefinition)")
                    .padding()
                    .background(Color("CardBackInsideColor"), in: .rect(cornerRadius: 15))
                    .padding()

                Spacer()
                VStack {
                    Image("SampleImage")
                        .resizable()
                        .scaledToFill()
                        .padding()
                    Text("\(cardData.exampleSentence)")
                        .padding()
                }
                
                .background(Color("CardBackInsideColor"), in: .rect(cornerRadius: 15))
                .padding()
                Spacer()


            }
            
        }
        .foregroundStyle(.white)
        .background(Color("CardBackColor") ,
                    in: CardBackShape())

        
    }
}

#Preview {
    ZStack {
        CardBackView(cardData:
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
    }}
