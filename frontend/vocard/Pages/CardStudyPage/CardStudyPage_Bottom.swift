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
    @Environment(CurrentCard.self) var currentCard
    @Environment(CardStudyPageViewModel.self) var vm: CardStudyPageViewModel
    
    @Query var allCards: [CardData]

    @State private var isResultPopoverPresented: Bool = false
    @State private var isRecentReviewSuccessed: Bool = false

    
    var body: some View {
        switch vm.cardViewStatus {
        case .front:
            EmptyView()
        case .back(.detail):
            Button {
                do {
                    try currentCard.cardData?.reviewFailed()
                    currentCard.cardData = allCards.pickOneByProbabilityOf(50)
                    vm.refresh()
                    print(currentCard.cardData)

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
                Button {
                    do {
                        try currentCard.cardData?.reviewFailed()
                        currentCard.cardData = allCards.pickOneByProbabilityOf(50)
                        vm.refresh()

                    } catch {
                        
                    }
                } label: {
                    Text("PASS")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.gray)
                
                Button {
                    do {
                        if currentCard.cardData?.wordData.quizzes.first?.answer == vm.selectedChoice ?? 0 {
                            try currentCard.cardData?.reviewFailed()
                            currentCard.cardData = allCards.pickOneByProbabilityOf(50)
                            vm.refresh()
                        } else {
                            try currentCard.cardData?.reviewFailed()
                            currentCard.cardData = allCards.pickOneByProbabilityOf(50)
                            vm.refresh()
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
                                Button("확인") {
                                    vm.refresh()
                                    dismiss()
                                }
                            }
                        }
                        
                    } else {
                        ZStack {
                            Color.white
                            VStack {
                                Text("틀렸습니다.")
                                Button("확인") {
                                    dismiss()
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
}
