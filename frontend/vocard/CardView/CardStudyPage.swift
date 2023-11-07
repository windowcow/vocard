//
//  ContentView.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI
import SwiftData
import Observation

//struct CurrentCardSide: PreferenceKey {
//    static var defaultValue: CardSide = .front
//    static func reduce(value: inout CardSide, nextValue: () -> CardSide) {
//        value = nextValue()
//    }
//}
//
//extension View {
//    func setCurrentCardSide(_ cardSide: CardSide) -> some View {
//        preference(key: CurrentCardSide.self, value: cardSide)
//    }
//}

//struct CurrentWordData: EnvironmentKey {
//    static var defaultValue: CardData = .example1
//}
//
//extension EnvironmentValues {
//    var currentCard: CardData {
//        get { self[CurrentWordData.self]}
//        set { self[CurrentWordData.self] = newValue }
//    }
//}
@Observable class CurrentCard {
    var cardData: CardData = .example1
    var cardSide: CardSide = .front
}

struct CardView: View {
    @Environment(CurrentCard.self) var currentCard
    @GestureState var offsetState: CGSize = CGSize.zero
    @State private var isCardDetailEditPresented: Bool = false
    
    @ViewBuilder
    func card() -> some View {
        switch currentCard.cardSide {
        case .front:
            ZStack {
                CardBackgroundView(cardFaceDirection: isNothingSelected() ? .faceUp : .faceDown,
                                   backgroundColor: isNothingSelected() ? .cardFacedUpBackground : .cardFacedDownBackground)

                if isNothingSelected() {
                    CardWordTextView()
                } else {
                    Text(isLeftSelected() ? "DETAIL" : "QUIZ")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .reflectedAboutY()
                }
            }
        case .detail:
            CardDetailView()
                .fullScreenCover(isPresented: $isCardDetailEditPresented) {
                    CardDetailEditView(cardData: .example1)
                }
                .onLongPressGesture {
                    withAnimation(.spring) {
                        isCardDetailEditPresented.toggle()
                    }
                }
            
        case .quiz:
            CardQuizView(quiz: Quiz.example)
            
        }
    }

    var body: some View {
        card()
            .visualEffect { content, geometryProxy in
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
                            state = value.translation
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            if isCardOffsetOutsideBoundary(.left, value.translation) {
                                currentCard.cardSide = .detail
                            } else if isCardOffsetOutsideBoundary(.right, value.translation){
                                currentCard.cardSide = .quiz
                            }
                        }
                    }
            )
        
    }
    
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
}


struct CardStudyPage: View {
    @Environment(CurrentCard.self) var currentCard

    var body: some View {
        ZStack {
            Color.mainBgr
                .ignoresSafeArea()
            VStack {
                CardStudyPageTop()
                Spacer()
                CardView()
                Spacer()
                CardStudyPageBottom(cardSide: currentCard.cardSide)
            }
        }
    }
    
}

struct CardStudyPageTop: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("TODAY'S WORD")
                        .font(.title2)
                    Text("128")
                        .font(.title2)
                        .fontWeight(.heavy)
                }
                Spacer()
                Button(action: {}){
                    Text("MENU")
                        .padding([.horizontal])
                        .padding([.vertical], 8)
                        .foregroundStyle(.black)
                        .background(.white, in: .rect(cornerRadius: 20))
                }
            }
            .padding(.horizontal)
            Divider()
                .background(.white)
        }
        .foregroundStyle(.white)
    }
    
}

struct CardStudyPageBottom: View {
    let cardSide: CardSide
    var body: some View {
        switch cardSide {
        case .front:
            EmptyView()
        case .detail:
            Button {
                
            } label: {
                Text("NEXT")
                    .foregroundStyle(.white)
                    .frame(width: 330, height: 63, alignment: .center)
                    .background(.cardFacedDownBackground, in: NextButtonShape())
                
            }
        case .quiz:
            Button {
                
            } label: {
                HStack(spacing: 23) {
                    Text("PASS")
                        .foregroundStyle(.white)
                        .frame(width: 107, height: 63, alignment: .center)
                        .background(.cardFacedDownBackground, in: PassButtonShape())
                    Text("SUBMIT")
                        .foregroundStyle(.black)
                        .frame(width: 200, height: 63, alignment: .center)
                        .background(.quizSubmitButton, in: NextButtonShape())

                }
                
            }
        }
        
    }
}

#Preview {
    CardStudyPage()
}
