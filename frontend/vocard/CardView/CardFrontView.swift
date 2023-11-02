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
            ZStack {
                Text("SCORE  **\(cardData.learningScore)**")
                    .font(.title3)
                    .position(x: geo.size.width / 4,
                              y: geo.size.height / 20)
                
                Text("\(cardData.originalWord)")
                    .font(.largeTitle)
                    .bold()
            }
            .background(Color("CardFrontColor") , in: CardFrontShape())
            
        }
    }
}

#Preview {
    ZStack {
        CardFrontView(cardData: .example)
            .draggable(cardSide: Binding<CardSide>.constant(CardSide.front))
    }
}
