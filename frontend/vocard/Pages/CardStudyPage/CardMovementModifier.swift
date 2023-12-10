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
    func movable(_ vm: CardStudyPageViewModel) -> some View {
        self.modifier(CardMovementModifier(vm: vm))
    }
}


struct CardMovementModifier: ViewModifier {
    @Bindable var vm: CardStudyPageViewModel
    @GestureState var offsetState: CGSize = .zero

    func body(content: Content) -> some View {
        content
            .visualEffect { (content, geometryProxy)  in
                content
                    .scaleEffect(offsetState.width > 0 ? (300 - offsetState.width) / 300 : (300 + offsetState.width) / 300)
                    .rotation3DEffect(
                        .degrees(offsetState.width),
                        axis: (x: 0.0, y: -1.0, z: 0.0),
                        anchor: .center
                    )
                    .offset(offsetState)
                    
                    
            }
            .animation(.spring.speed(2), value: offsetState)
            .gesture(
                DragGesture()
                    .updating($offsetState) { value, state, t in
                        state = value.translation

                        switch state.width {
                        case let x where CardMovementLocation.left.range ~= x:
                            vm.cardViewStatus = .front(.left)
                        case let x where CardMovementLocation.right.range ~= x:
                            vm.cardViewStatus = .front(.right)
                        default:
                            vm.cardViewStatus = .front(.middle)
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            switch value.translation.width {
                            case let x where CardMovementLocation.center.range ~= x:
                                vm.cardViewStatus = .front(.middle)
                            case let x where CardMovementLocation.left.range ~= x:
                                vm.cardViewStatus = .back(.detail)
                            case let x where CardMovementLocation.right.range ~= x:
                                vm.cardViewStatus = .back(.quiz)
                            default:
                                vm.cardViewStatus = .front(.middle)
                            }
                        }
                    }
            )
        
    }
}
