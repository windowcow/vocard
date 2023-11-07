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

struct CardFrontView: View {
    @GestureState var offsetState: CGSize = CGSize.zero
    @Binding var cardSide: CardSide
    @Namespace var namespace
    let cardData: CardData
    
    func isCardOffsetOutsideBoundary(_ direction: CardDirection, _ currentOffset: CGSize) -> Bool {
        if direction == .left {
            return currentOffset.width <= -AppSettings.cardMenuChangeOffsetCriterion
        } else {
            return currentOffset.width >= AppSettings.cardMenuChangeOffsetCriterion
        }
    }
    
    func isNothingSelected() -> Bool {
        return !isLeftSelected() && !isRightSelected()
    }
    
    func isLeftSelected() -> Bool {
        return isCardOffsetOutsideBoundary(.left, offsetState)
    }
    
    func isRightSelected() -> Bool {
        return isCardOffsetOutsideBoundary(.right, offsetState)
    }
    
    var body: some View {
        ZStack {
            CardBackgroundView(cardFaceDirection: isNothingSelected() ? .faceUp : .faceDown,
                               backgroundColor: isNothingSelected() ? .cardFront : .cardBack)
            
            if isNothingSelected() {
                CardWordTextView(cardData: cardData, cardType: .front)
            } else {
                Text(isLeftSelected() ? "DETAIL" : "QUIZ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .reflectedAboutY()
            }
        }
        .visualEffect { content, geometryProxy in
            content
                .offset(offsetState)
                .rotation3DEffect(
                    .degrees(offsetState.width),
                    axis: (x: 0.0, y: -1.0, z: 0.0),
                    anchor: offsetState.width > 0 ? .trailing : .leading
                )
        }
        .gesture(
            DragGesture()
                .updating($offsetState) { value, state, t in
                    withAnimation {
                        state = value.translation // .applying(.init(scaleX: 1.5, y: 1.5))
                    }
                }
                .onEnded { value in
                    withAnimation {
                        if isCardOffsetOutsideBoundary(.left, value.translation) {
                            cardSide = .detail
                        } else if isCardOffsetOutsideBoundary(.right, value.translation){
                            cardSide = .quiz
                        }
                    }
                }
        )
        .animation(.spring.speed(2), value: offsetState)
        
        
    }
}


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
