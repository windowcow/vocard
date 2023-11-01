//
//  DraggableModifier.swift
//  vocard
//
//  Created by windowcow on 10/30/23.
//

import SwiftUI

struct DraggableModifier: ViewModifier {
    @GestureState var offsetState: CGSize = CGSize.zero
    @Binding var cardSide: CardSide

    func body(content: Content) -> some View {
        return content
            .offset(offsetState)
            .rotationEffect(
                .degrees(offsetState.width / 20.0),
                anchor: .bottom
            )
            .gesture(
                DragGesture()
                    .updating($offsetState) { value, state, _ in
                        withAnimation {
                            state = value.translation.applying(.init(scaleX: 1.5, y: 1.5))
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            if value.translation.width < -100 {
                                cardSide = .detail
                            } else if value.translation.width > 100 {
                                cardSide = .quiz
                            }
                        }
                    }
            )
            .animation(.spring.speed(3), value: offsetState)
    }
}


extension View {
    func draggable(cardSide: Binding<CardSide>) -> some View {
        self.modifier(DraggableModifier(cardSide: cardSide))
    }
}

