//
//  CardStudyPage_Middle_Card_Quiz.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI
import SwiftData

struct CardStudyPage_Middle_Card_Quiz_ChoiceButton: View {
    @Environment(CardStudyPageViewModel.self) var vm: CardStudyPageViewModel
    @Environment(CurrentCard.self) var currentCard

    var currentChoiceNum: Int
    var quizData: QuizData
    
    var body: some View {
        @Bindable var vm = vm

        if vm.selectedChoice ?? 0 == currentChoiceNum  {
            Button{
                vm.selectedChoice = currentChoiceNum
            } label: {
                Text(quizData.choices[currentChoiceNum - 1])
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
            .controlSize(.extraLarge)
            .tint(.purple)
        } else {
            Button{
                vm.selectedChoice = currentChoiceNum
            } label: {
                Text(quizData.choices[currentChoiceNum - 1])
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .padding(.horizontal)
            .controlSize(.extraLarge)
            .tint(.purple)
        }
    }
}




struct CardStudyPage_Middle_Card_Quiz: View {
    @Environment(CardStudyPageViewModel.self) var vm: CardStudyPageViewModel
    @Environment(\.modelContext) private var modelContext
    @Query private var quizData: [QuizData]
    
    init(_ word: WordData) {
        _quizData = Query(filter: QuizData.predicate(headword: word.headWord, senNum: word.senseNum))
        print(quizData.debugDescription)
    }
    
    
    var body: some View {
        CardBackgroundView(backgroundColor: .white)
            .shadow(radius: 30)
            .overlay {
                VStack {
                    if let quizData = quizData.first {
                        Text(quizData.question)
                            .padding(.top, 50)
                        Spacer()
                        VStack {
                            CardStudyPage_Middle_Card_Quiz_ChoiceButton(currentChoiceNum: 1, quizData: quizData)
                            CardStudyPage_Middle_Card_Quiz_ChoiceButton(currentChoiceNum: 2, quizData: quizData)
                            CardStudyPage_Middle_Card_Quiz_ChoiceButton(currentChoiceNum: 3, quizData: quizData)
                            CardStudyPage_Middle_Card_Quiz_ChoiceButton(currentChoiceNum: 4, quizData: quizData)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()
                    }
                }
            }
//            .task {
//                print(quizData.debugDescription)
//            }
    }
}

#Preview {
    CardStudyPage()
        .padding()
}
