//
//  ContentView.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI
import SwiftData
import Observation

@Observable fileprivate class CardStudyPageViewModel {
    /// enums
    var isCardDetailEditPresented = false
    var definitionType: DefinitionType = .english
    var cardViewStatus: CardViewStatus = .front(.middle)
    
    
    
    
    /// normal datas
    var selectedOption: Int?
    var isScored: Bool = false

    
    /// state datas
    var cardOffsetGestureState: GestureState<CGSize> = .init(initialValue: .zero)

    
}

fileprivate enum DefinitionType {
    case english, korean
}

fileprivate enum CardViewStatus {
    enum CardFrontStatus {
        case left, middle, right
    }
    
    enum CardBackStatus {
        case detail, quiz
    }

    case front(CardFrontStatus)
    case back(CardBackStatus)
}



struct CardStudyPage: View {
    @Environment(CurrentCard.self) var currentCard
    @State private var viewModel = CardStudyPageViewModel()
    
    var body: some View {
        ZStack {
            Color.mainBgr
                .ignoresSafeArea()
            VStack {
                CardStudyPageTop()
                Spacer()
                CardStudyPageMiddle()
                Spacer()
                CardStudyPageBottom()
            }
        }
    }
    
    /// Subviews
    ///
    
    @ViewBuilder
    func CardStudyPageTop() -> some View {
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
    
    @ViewBuilder
    func CardStudyPageBottom() -> some View {
        switch currentCard.cardSideState {
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
    
    @ViewBuilder
    func CardStudyPageMiddle() -> some View {
        card()
            .cardMovement(currentCard.cardOffsetState)
            
    }
    @ViewBuilder
    func CardForegroundView() -> some View {
        switch viewModel.cardViewStatus {
        case .front(let cardFrontStatus):
            switch cardFrontStatus {
            case .middle:
                CardWordTextView()
            case .left:
                Text("DETAIL" )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .reflectedAboutY()
            case .right:
                Text("QUIZ" )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .reflectedAboutY()
                
            }
        case .back(let cardBackStatus):
            switch cardBackStatus {
            case .detail:
                CardDetailView()
                    .popover(isPresented: $viewModel.isCardDetailEditPresented) {
                        CardDetailEditView(cardData: .example1)
                            .presentationCompactAdaptation(.fullScreenCover)
                    }
                    .onLongPressGesture {
                        withAnimation(.spring) {
                            viewModel.isCardDetailEditPresented.toggle()
                        }
                    }
                
            case .quiz:
                CardQuizView()
            }
        }
    }
    
    @ViewBuilder
    func CardBackgroundView() -> some View {
        
        switch viewModel.cardViewStatus {
        case .front(let cardFrontStatus):
            switch cardFrontStatus {
            case .middle:
                CardFrontShape()
                    .fill(.cardFacedUpBackground)
                    .frame(width: 338, height: 553)
            case .left:
                CardBackShape()
                    .fill(.cardFacedDownBackground)
                    .frame(width: 338, height: 553)
                    .reflectedAboutY()
            case .right:
                CardBackShape()
                    .fill(.cardFacedDownBackground)
                    .frame(width: 338, height: 553)
                    .reflectedAboutY()
                
            }
        case .back(let cardBackStatus):
            switch cardBackStatus {
            case .detail:
                CardBackShape()
                    .fill(.cardFacedDownBackground)
                    .frame(width: 338, height: 553)
                    .reflectedAboutY()
            case .quiz:
                CardBackShape()
                    .fill(.cardFacedDownBackground)
                    .frame(width: 338, height: 553)
                    .reflectedAboutY()
            }
            
            
        }
    }
    @ViewBuilder
    func card() -> some View {
        ZStack {
            CardBackgroundView()
            CardForegroundView()
        }
    }
    
    
    @ViewBuilder
    func CardDetailView() -> some View {
        
        ZStack {
            CardBackgroundView()

            VStack(spacing: 20) {
                Color.clear
                    .frame(height: 25)
                CardWordTextView()
                CardDetailDefinition()
                CardDetailExampleImageSentenceView()
            }
        }
        .foregroundStyle(.white)
    }

    
    func CardDetailDefinition() -> some View {
        
        Button {
            if viewModel.definitionType == .english {
                viewModel.definitionType = .korean
            } else {
                viewModel.definitionType = .english
            }
        } label: {
            Text(viewModel.definitionType == .english ? currentCard.cardData.englishDefinition : currentCard.cardData.koreanDefinition)
                .frame(width: 288, height: 60)
                .background(.cardBackInside, in: .rect(cornerRadius: 10))
        }
    }

    struct CardWordTextView: View {
        @Environment(CurrentCard.self) var currentCard
        
        var body: some View {
            Text(currentCard.cardData.originalWord)
                .foregroundStyle(currentCard.cardSideState == .front ? .black : .white)
                .font(.largeTitle)
                .fontWeight(.heavy)
        }
    }
    
    @ViewBuilder
    func CardQuizView() -> some View {

        ZStack {
            CardBackgroundView()

            VStack(spacing: 20) {
                HStack {
                    Text("Q")
                        .padding()
                        .font(.largeTitle)
                        .bold()
                    Text(currentCard.cardData.quizes.first!.question)
                        .frame(width: 213)
                }
                .padding(.horizontal, 20)
                
                VStack(spacing: 20) {
                    OptionButton(selectedOption: $viewModel.selectedOption,
                                 isScored: viewModel.isScored,
                                 quiz: currentCard.cardData.quizes.first!,
                                 currentOptionNumber: 1)
                    
                    OptionButton(selectedOption: $viewModel.selectedOption,
                                 isScored: viewModel.isScored,
                                 quiz: currentCard.cardData.quizes.first!,
                                 currentOptionNumber: 2)
                    OptionButton(selectedOption: $viewModel.selectedOption,
                                 isScored: viewModel.isScored,
                                 quiz: currentCard.cardData.quizes.first!,
                                 currentOptionNumber: 3)
                    OptionButton(selectedOption: $viewModel.selectedOption,
                                 isScored: viewModel.isScored,
                                 quiz: currentCard.cardData.quizes.first!,
                                 currentOptionNumber: 4)
                }
            }
        }
        .font(.system(size: 16))
    }
}



extension View {
    func cardMovement(@GestureState _ offset: CGSize) -> some View {
        self
            .modifier(CardMovementModifier(offsetState: offset))
    }
}

struct CardMovementModifier: ViewModifier {
    func isCardOffsetOutsideBoundary(_ direction: CardDirection, @GestureState _ currentOffset: CGSize) -> Bool {
        if direction == .left {
            return currentOffset.width <= -CardDragSettings.cardMenuOffsetCriterion
        } else {
            return currentOffset.width >= CardDragSettings.cardMenuOffsetCriterion
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

    
    @GestureState var offsetState: CGSize
    @State private var isCardDetailEditPresented: Bool = false
    @Environment(CurrentCard.self) var currentCard
    
    func body(content: Content) -> some View {
        content
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
                                currentCard.cardSideState = .detail
                            } else if isCardOffsetOutsideBoundary(.right, value.translation){
                                currentCard.cardSideState = .quiz
                            }
                        }
                    }
            )
    }
}


#Preview {
    CardStudyPage()
}
