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
            .background(Color("CardFrontColor") , in: CardFrontShape())
            .frame(width: geo.size.width,
                   height: geo.size.height)
        }
        

        
    }
}

#Preview {
    ZStack {
        CardFrontView(cardData: .example)
            .draggable(cardSide: Binding<CardSide>.constant(CardSide.front))
    }
}
