//
//  MainPage_CardStudyPage_Middle.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftUI

struct CardStudyPage_Middle: View {
    @Environment(CardDataModel.self) var currentCard: CardDataModel?
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                Color.clear
                CardStudyPage_Middle_Card()
                
            }
        }
    }
}

struct CardStudyPage_Middle_Card: View {
    @Environment(CardDataModel.self) var currentCard: CardDataModel?
    @State private var currentCardViewState: CardViewStatus = .front(.middle)
    
    var body: some View {
        switch currentCardViewState {
        case .front(let currentCardFrontViewState):
            CardStudyPage_Middle_Card_Front(currentCardFrontViewState: Binding(get: {currentCardFrontViewState},
                                                                               set: { newValue in
                currentCardViewState = .front(newValue)
            }), headword: "")
        case .back(let cardBackStatus):
            switch cardBackStatus {
            case .detail:
                CardStudyPage_Middle_Card_Detail()
            case .quiz:
                CardStudyPage_Middle_Card_Quiz()
            }
        }
    }
}

struct CardStudyPage_Middle_Card_Detail: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

struct CardStudyPage_Middle_Card_Quiz: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

enum CardMovementLocation {
    case left, center, right
    
    var range: Range<CGFloat> {
        switch self {
        case .left:
            -CGFloat.infinity ..< -90
        case .center:
            -90 ..< 90
        case .right:
            90 ..< CGFloat.infinity
        }
    }
}

enum CardViewStatus: Equatable {
   enum CardFrontStatus {
       case left, middle, right
   }
   
   enum CardBackStatus {
       case detail, quiz
   }
   
   case front(CardFrontStatus)
   case back(CardBackStatus)
}

enum DefinitionType {
    case korean, english
}

@Observable  class CardStudyPageViewModel {
    /// enums
    var isCardDetailEditPresented = false
    var definitionType: DefinitionType = .english
    var cardViewStatus: CardViewStatus = .front(.middle)
    
    
    
    
    /// normal datas
    var selectedOption: Int?
    var isScored: Bool = false

    
    /// state datas
    var cardOffset: CGSize = .zero

    
}

extension View {
    @ViewBuilder
    func movable(_ viewModel: CardStudyPageViewModel) -> some View {
        self.modifier(CardMovementModifier(viewModel: viewModel))
    }
}


struct CardMovementModifier: ViewModifier {
    @Bindable var viewModel: CardStudyPageViewModel

    @State private var isCardDetailEditPresented: Bool = false

    @GestureState var offsetState: CGSize = .zero

    func body(content: Content) -> some View {
        switch viewModel.cardViewStatus {
        case .front:
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
                            withAnimation {
                                
                            }
                            state = value.translation

                            switch state.width {
    //                        case let x where CardMovementLocation.center.range ~= x:
    //                            viewModel.cardViewStatus = .front(.middle)
                            case let x where CardMovementLocation.left.range ~= x:
                                viewModel.cardViewStatus = .front(.left)
                            case let x where CardMovementLocation.right.range ~= x:
                                viewModel.cardViewStatus = .front(.right)
                            default:
                                viewModel.cardViewStatus = .front(.middle)
                            }
                        }
                        .onEnded { value in
                            withAnimation {
                                switch value.translation.width {
                                case let x where CardMovementLocation.center.range ~= x:
                                    viewModel.cardViewStatus = .front(.middle)
                                case let x where CardMovementLocation.left.range ~= x:
                                    viewModel.cardViewStatus = .back(.detail)
                                case let x where CardMovementLocation.right.range ~= x:
                                    viewModel.cardViewStatus = .back(.quiz)
                                default:
                                    viewModel.cardViewStatus = .front(.middle)
                                    print("123")
                                }
                            }
                        }
                )
        case .back:
            content
        }
        
    }
}

#Preview {
    MainPage()
        .modelContainer(sharedModelContainer)
}
