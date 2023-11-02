//
//  CardQuizView.swift
//  vocard
//
//  Created by windowcow on 10/29/23.
//

import SwiftUI

struct Quiz {
    let question: String
    
    let choice1: String
    let choice2: String
    let choice3: String
    let choice4: String
    let answer: Int
    
    static let example = Quiz(
        question: "What's the capital of France?",
        choice1: "Berlin",
        choice2: "Madrid",
        choice3: "Paris",
        choice4: "Rome",
        answer: 3
    )
}
struct OptionButton: View {
    @Binding var selectedOption: Int?
    let isScored: Bool
    let quiz: Quiz
    let currentOptionNumber: Int

    var body: some View {
        Button {
            selectedOption = currentOptionNumber
        } label: {
            Text(quiz.choice1)
                
                .padding(.vertical)
                .padding(.horizontal, 150)
                .background(.quizOption, in: .rect(cornerRadius: 15))
                .optionStyle(answer: quiz.answer,
                             currentOption: currentOptionNumber, selectedOption: $selectedOption, isScored: isScored)

        }
    }
}

struct CardQuizView: View {
    let quiz: Quiz
    var cardData = CardData.example
    @State private var selectedOption: Int? = nil
    @State private var isScored: Bool = false
    

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Text("-> 3 TIMES")
                    .font(.title3)
                    .position(x: geo.size.width * 3 / 4,
                              y: geo.size.height / 20)
                
                VStack {
                    HStack {
                        Text("Q")
                            .font(.largeTitle)
                            .bold()
                            .padding(.leading)
                        Text(quiz.question)
                        Spacer()
                    }
                    .padding(.horizontal)
                    VStack(alignment: .leading, spacing: 20) {
                        OptionButton(selectedOption: $selectedOption,
                                     isScored: isScored,
                                     quiz: quiz,
                                     currentOptionNumber: 1)
                        OptionButton(selectedOption: $selectedOption,
                                     isScored: isScored,
                                     quiz: quiz,
                                     currentOptionNumber: 2)
                        OptionButton(selectedOption: $selectedOption,
                                     isScored: isScored,
                                     quiz: quiz,
                                     currentOptionNumber: 3)
                        OptionButton(selectedOption: $selectedOption,
                                     isScored: isScored,
                                     quiz: quiz,
                                     currentOptionNumber: 4)
                    }
                }
                .frame(width: .infinity,
                       height: .infinity)

                .foregroundStyle(.black)

            }
            .background(.white, in: CardBackShape())
            
        }
        
    }
}

extension View {
    func customButtonStyle(geo: GeometryProxy) -> some View {
        self
            .frame(width: geo.size.width * 8 / 9, height: geo.size.height / 15)
            .background(Color.quizOption , in: RoundedRectangle(cornerRadius: 10))
            
    }
}

/// >>> Option Modifier
struct OptionModifier: ViewModifier {
    let answer: Int
    let currentOption: Int
    @Binding var selectedOption: Int?
    let isScored: Bool
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if isScored {
            if currentOption == answer {
                content.shadow(color: .blue, radius: 5, x: 0.0, y: 0.0)
            } else {
                content.shadow(color: .red, radius: 5, x: 0.0, y: 0.0)
            }
        } else {
            if let selectedOpt = selectedOption, selectedOpt == currentOption {
                content.shadow(color: .green, radius: 5, x: 0.0, y: 0.0)
                
                
            } else {
                content
            }
        }
    }
}

extension View {
    func optionStyle(answer: Int, currentOption: Int, selectedOption: Binding<Int?>, isScored: Bool) -> some View {
        self.modifier(OptionModifier(answer: answer, currentOption: currentOption, selectedOption: selectedOption, isScored: isScored))
    }
}

///  Option Modifier <<<


#Preview {
    ZStack {
        Color.black
        CardQuizView(quiz: Quiz.example)
            

    }
}
