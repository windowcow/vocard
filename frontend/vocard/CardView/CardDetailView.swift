//
//  CardBackView.swift
//  vocard
//
//  Created by windowcow on 10/27/23.
//

import SwiftUI

struct CardDetailView: View {
    @State var cardData: CardData
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Text("SCORE  **\(cardData.learningScore)**")
                    .font(.title3)
                    .position(x: geo.size.width * 3 / 4,
                              y: geo.size.height / 20)
                VStack {
                    Text("\(cardData.originalWord)")
                        .font(.largeTitle)
                        .bold()
                        .position(x: geo.size.width / 2,
                                  y: geo.size.height / 5)
    
                    Text("\(cardData.englishDefinition)")
                        .padding()
                        .background(Color("CardBackInsideColor"), in: .rect(cornerRadius: 15))
                        .padding()
                    
                    VStack {
                        Image("SampleImage")
                            .resizable()
                            .scaledToFill()
                            .padding()
                        Text("\(cardData.exampleSentence)")
                            .padding()
                    }
                    .background(Color("CardBackInsideColor"), in: .rect(cornerRadius: 15))                    .padding()
                    
                }
            }
            .background(Color.cardBack ,
                        in: CardBackShape())
            .foregroundStyle(.white)
        }
    }
}

struct CardDetailEditView: View {
    @State var cardData: CardData

    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer(minLength: 50)

                Text("\(cardData.originalWord)")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                VStack {
                    Image("SampleImage")
                        .resizable()
                        .scaledToFill()
                        .padding()
                    Text("\(cardData.exampleSentence)")
                }
                .background(Color("CardBackInsideColor"), in: .rect(cornerRadius: 15))
                .padding()
                Spacer()
                Button{} label: {
                    Text("이 예문으로 설정하기")
                        .foregroundStyle(.black)
                        .padding()
                        .background(.white, in: .rect(cornerRadius: 15))
                }
                Spacer(minLength: 50)
            }
            .foregroundStyle(.white)
            .background(Color.cardBackInside, in: .rect(cornerRadius: 15))
            .scaledToFit()
        }
        
    }
}

#Preview {
    ZStack {
        CardDetailView(cardData: CardData.example)

//        CardDetailEditView(cardData: CardData.example)
    }
}
