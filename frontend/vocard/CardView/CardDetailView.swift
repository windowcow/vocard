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
            VStack {
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
            .frame(width: geo.size.width,
                   height: geo.size.height)
        }
        

        
    }
}

#Preview {
    ZStack {
        CardDetailView(cardData: CardData.example)
            .padding()
    }
}
