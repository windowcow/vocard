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

struct QuizContentsView: View {
    let quiz: Quiz
    let geo: GeometryProxy
    @State private var selectedOption: Int?
    @State private var isScored: Bool = false

    var body: some View {
        HStack {
            Text("Q")
                .font(.largeTitle)
                .bold()
                .padding(.leading)
            Text(quiz.question)
            Spacer()
        }
        .frame(width: geo.size.width)
        .padding(.horizontal)
        Spacer()
        VStack(alignment: .leading, spacing: 20) {
            Button {
                selectedOption = 1
            } label: {
                Text(quiz.choice1)
                    .customButtonStyle(geo: geo)
                    .optionStyle(answer: quiz.answer, currentOption: 1, selectedOption: $selectedOption, isScored: isScored)

            }
            Button{
                selectedOption = 2
            } label:  {
                Text(quiz.choice2)
                    .customButtonStyle(geo: geo)
                    .optionStyle(answer: quiz.answer, currentOption: 2, selectedOption: $selectedOption, isScored: isScored)

            }
            Button {
                selectedOption = 3
            } label: {
                Text(quiz.choice3)
                    .customButtonStyle(geo: geo)
                    .optionStyle(answer: quiz.answer, currentOption: 3, selectedOption: $selectedOption, isScored: isScored)

            }
            Button {
                selectedOption = 4
            } label: {
                Text(quiz.choice4)
                    .customButtonStyle(geo: geo)
                    .optionStyle(answer: quiz.answer, currentOption: 4, selectedOption: $selectedOption, isScored: isScored)

            }
        }
        .foregroundStyle(.black)
    }
}


struct CardQuizView: View {
    let quiz: Quiz
    @State private var selectedOption: Int?
    @State private var isScored: Bool = false

    var body: some View {
        GeometryReader { geo in
            VStack {
                Color.clear.frame(height: 20)

                HStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("-> 3 TIMES")
                    

                    Spacer()

                }
                .frame(height: geo.size.height / 10,
                       alignment: .top)
                
                QuizContentsView(quiz: quiz, geo: geo)
                
                Spacer()

            }

            .frame(width: geo.size.width,
                   height: geo.size.height)
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
