//
//  CardStudyPage_Middle_Card_Quiz.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI

struct CardStudyPage_Middle_Card_Quiz_ChoiceButton: View {
    var isSelected: Bool
    var text: String
    var action: () -> ()
    
    var body: some View {
        if isSelected {
            Button{
                action()
            } label: {
                Text(text)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
            .controlSize(.extraLarge)
            .tint(.purple)
        } else {
            Button{
                action()
            } label: {
                Text(text)
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
    @Environment(CardDataModel.self) var currentCard: CardDataModel?
    @Binding var selectedChoice: Int?
    
    var body: some View {
        CardBackgroundView(backgroundColor: .white)
            .shadow(radius: 30)
            .overlay {
                VStack {
                    Text(currentCard?.targetWordDataModel.quizzes.first?.question ?? "Which of the following is not typically associated with a meaningful conversation")
                        .padding(.top, 50)
                    Spacer()
                    VStack {
                        CardStudyPage_Middle_Card_Quiz_ChoiceButton(isSelected: selectedChoice ?? 0 == 1,
                                                                    text: currentCard?.targetWordDataModel.quizzes[0].choices[0] ?? "First") {
                            selectedChoice = 1
                        }
                        CardStudyPage_Middle_Card_Quiz_ChoiceButton(isSelected: selectedChoice ?? 0 == 2,
                                                                    text: currentCard?.targetWordDataModel.quizzes[0].choices[1] ?? "First") {
                            selectedChoice = 2
                        }
                        CardStudyPage_Middle_Card_Quiz_ChoiceButton(isSelected: selectedChoice ?? 0 == 3,
                                                                    text: currentCard?.targetWordDataModel.quizzes[0].choices[2] ?? "First") {
                            selectedChoice = 3
                        }
                        CardStudyPage_Middle_Card_Quiz_ChoiceButton(isSelected: selectedChoice ?? 0 == 4,
                                                                    text: currentCard?.targetWordDataModel.quizzes[0].choices[3] ?? "First") {
                            selectedChoice = 4
                        }
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
