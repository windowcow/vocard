//
//  CardStudyPage_Middle_Card_Quiz.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI

struct CardStudyPage_Middle_Card_Quiz_ChoiceButton: View {
    @Environment(CardStudyPageViewModel.self) var vm: CardStudyPageViewModel
    @Environment(CurrentCard.self) var currentCard

    var currentChoiceNum: Int
    
    var body: some View {
        if let currentQuiz = currentCard.currentCard?.targetWordDataModel.quizzes.first {
            let _ = print(currentQuiz)
            if vm.selectedChoice ?? 0 == currentChoiceNum  {
                Button{
                    vm.selectedChoice = currentChoiceNum
                } label: {
                    Text(currentQuiz.choices[currentChoiceNum - 1])
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
                    Text(currentQuiz.choices[currentChoiceNum - 1])
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .padding(.horizontal)
                .controlSize(.extraLarge)
                .tint(.purple)
            }
        }
    }
}

struct CardStudyPage_Middle_Card_Quiz: View {
    @Environment(CardDataModel.self) var currentCard: CardDataModel?
    @Environment(CardStudyPageViewModel.self) var vm: CardStudyPageViewModel
    
    var body: some View {
        CardBackgroundView(backgroundColor: .white)
            .shadow(radius: 30)
            .overlay {
                VStack {
                    Text(currentCard?.targetWordDataModel.quizzes.first?.question ?? "Which of the following is not typically associated with a meaningful conversation")
                        .padding(.top, 50)
                    Spacer()
                    VStack {
                        CardStudyPage_Middle_Card_Quiz_ChoiceButton(currentChoiceNum: 1)
                        CardStudyPage_Middle_Card_Quiz_ChoiceButton(currentChoiceNum: 2)
                        CardStudyPage_Middle_Card_Quiz_ChoiceButton(currentChoiceNum: 3)
                        CardStudyPage_Middle_Card_Quiz_ChoiceButton(currentChoiceNum: 4)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()

                }
            }
    }
}

#Preview {
    CardStudyPage()
        .padding()
}
