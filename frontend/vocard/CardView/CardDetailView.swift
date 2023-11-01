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
                .padding(.top)
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
            .foregroundStyle(.white)
            .background(Color("CardBackColor") ,
                        in: CardBackShape())
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
        
        CardDetailEditView(cardData: CardData.example)
    }
}
