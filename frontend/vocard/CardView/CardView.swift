//
//  CardView.swift
//  vocard
//
//  Created by windowcow on 10/29/23.
//

import SwiftUI

enum CardSide {
    case front, detail, quiz, detailEdit
}

struct CardView: View {
    @State private var cardSide: CardSide = .front
    
    var body: some View {
        GeometryReader { geo in
            switch cardSide {
            case .front:
                CardFrontView(cardData: .example)
                    .frame(width: geo.size.width,
                           height: geo.size.height / 8 * 7,
                           alignment: .top)
                    .draggable(cardSide: $cardSide)
            case .detail:
                CardDetailView(cardData: .example)
                    .frame(width: geo.size.width,
                           height: geo.size.height / 8 * 6,
                           alignment: .top)
                    .onLongPressGesture {
                        withAnimation(.spring) {
                            cardSide = .detailEdit
                        }
                    }
            case .detailEdit:
                CardDetailEditView(cardData: .example)
            case .quiz:
                VStack {
                    CardQuizView(quiz: Quiz.example)
                        .frame(width: geo.size.width,
                               height: geo.size.height / 8 * 7,
                               alignment: .top)
                    
                    CardQuizBottomButtonView()
                        .frame(width: geo.size.width,
                               height: geo.size.height / 8 * 1,
                               alignment: .bottom)
                }
            }
        }
        
    }
}

#Preview {
    CardView()
}
