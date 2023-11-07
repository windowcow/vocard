//
//  CardFrontView.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI

enum CardDirection {
    case left, right
}

struct AppSettings {
    static var cardMenuChangeOffsetCriterion: CGFloat = 90
}

//struct CardFrontView: View {
//    @Binding var cardSide: CardSide
//    @Namespace var namespace
//    
//    let cardData: CardData
//    
//    
//    
//    var body: some View {
//        
//        
//        
//        
//    }
//}


struct ReflectedAboutY: ViewModifier {
    func body(content: Content) -> some View {
        content
            .visualEffect { content, _ in
                    content
                        .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
            }
    }
}

extension View {
    func reflectedAboutY() -> some View {
        self.modifier(ReflectedAboutY())
    }
}


//#Preview {
//    ZStack {
//        CardFrontView(cardData: .example1)
//            .cardDragModifier(cardSide: Binding<CardSide>.constant(CardSide.front))
//    }
//}
