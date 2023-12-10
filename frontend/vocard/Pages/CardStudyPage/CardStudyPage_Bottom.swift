//
//  CardStudyPage_Bottom.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/3/23.
//

import Foundation
import SwiftUI
import SwiftData

struct CardStudyPage_Bottom: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Environment(CurrentCard.self) var currentCard
    @Environment(CardStudyPageViewModel.self) var vm: CardStudyPageViewModel
    @Environment(Probability.self) var cardProb
    @Query var allCards: [CardData]

    @State private var isResultPopoverPresented: Bool = false
    @State private var isRecentReviewSuccessed: Bool = false

    
    var body: some View {
        @Bindable var vm = vm
        @Bindable var currentCard = currentCard
        switch vm.cardViewStatus {
        case .front:
            EmptyView()
        case .back(.detail):
            Button { @MainActor in
                do {
                    try currentCard.cardData?.reviewFailed()
                    currentCard.cardData = allCards.getCard(unseenCardProb: cardProb.probability)
                    vm.refresh()
//                    print(currentCard.cardData?.wordData.headword)
//                    print(currentCard.cardData?.timeSinceLastReview)

                } catch {
                    
                }

                
            } label: {
                Text("NEXT")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
        case .back(.quiz):
            HStack {
                Button { @MainActor in
                    do {
                        try currentCard.cardData?.reviewFailed()
                        currentCard.cardData = allCards.getCard(unseenCardProb: cardProb.probability)
                        vm.refresh()

                    } catch {
                        
                    }
                } label: {
                    Text("PASS")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.gray)
                
                Button { @MainActor in
                    do {
                        if let quiz = currentCard.cardData?.wordData.quizzes.first, let choice = vm.selectedChoice {
                            if quiz.answer == choice {
                                try currentCard.cardData?.reviewSuccessed()
                                isRecentReviewSuccessed = true
                                isResultPopoverPresented.toggle()
                            } else {
                                try currentCard.cardData?.reviewFailed()
                                isRecentReviewSuccessed = false
                                isResultPopoverPresented.toggle()
                            }
                        }

                    } catch {
                        
                    }
                } label: {
                    Text("SUBMIT")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
                .popover(isPresented: $isResultPopoverPresented) {
                        
                    if isRecentReviewSuccessed {
                        ZStack {
                            Color.white
                            VStack {
                                Text("맞췄습니다")
                                    .font(.largeTitle)
                                    .bold()
                                Button { @MainActor in
                                    vm.refresh()
                                    isResultPopoverPresented.toggle()
                                    currentCard.cardData = allCards.getCard(unseenCardProb: cardProb.probability)
                                } label: {
                                    Text("확인")
                                        .frame(maxWidth: .infinity)
                                }
                                .padding(.horizontal, 30)
                                .buttonStyle(.borderedProminent)
                                
                            }
                        }
                        
                    } else {
                        ZStack {
                            Color.white
                            VStack {
                                Text("틀렸습니다.")
                                    .font(.largeTitle)
                                    .bold()
                                Button { @MainActor in
                                    vm.refresh()
                                    isResultPopoverPresented.toggle()
                                    currentCard.cardData = allCards.getCard(unseenCardProb: cardProb.probability)
                                } label: {
                                    Text("확인")
                                        .frame(maxWidth: .infinity)
                                }
                                .padding(.horizontal, 30)
                                .buttonStyle(.borderedProminent)
                            }
                        }
                    }
                }
            }
        }
    }
}
