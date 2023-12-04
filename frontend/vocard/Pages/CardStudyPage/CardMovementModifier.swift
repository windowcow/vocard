//
//  CardMovementModifier.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func movable(_ viewModel: CardStudyPageViewModel, _ cardViewStatus: Binding<CardViewStatus>) -> some View {
        self.modifier(CardMovementModifier(viewModel: viewModel, cardViewStatus: cardViewStatus))
    }
}


struct CardMovementModifier: ViewModifier {
    @Bindable var viewModel: CardStudyPageViewModel
    @Binding var cardViewStatus: CardViewStatus
    @GestureState var offsetState: CGSize = .zero

    func body(content: Content) -> some View {
        content
            .visualEffect { (content, geometryProxy)  in
                content
                    .offset(offsetState)
                    .rotation3DEffect(
                        .degrees(offsetState.width),
                        axis: (x: 0.0, y: -1.0, z: 0.0),
                        anchor: offsetState.width > 0 ? .trailing : .leading
                    )
            }
            .animation(.spring.speed(2), value: offsetState)
            .gesture(
                DragGesture()
                    .updating($offsetState) { value, state, t in
                        state = value.translation

                        switch state.width {
                        case let x where CardMovementLocation.left.range ~= x:
                            print(111)
                            viewModel.cardViewStatus = .left
                        case let x where CardMovementLocation.right.range ~= x:
                            viewModel.cardViewStatus = .right
                        default:
                            viewModel.cardViewStatus = .middle
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            switch value.translation.width {
                            case let x where CardMovementLocation.center.range ~= x:
                                cardViewStatus = .front
                            case let x where CardMovementLocation.left.range ~= x:
                                cardViewStatus = .detail
                            case let x where CardMovementLocation.right.range ~= x:
                                cardViewStatus = .quiz
                            default:
                                cardViewStatus = .front
                            }
                        }
                    }
            )
        
    }
}
