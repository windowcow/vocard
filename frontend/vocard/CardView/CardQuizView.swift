//
//  CardQuizView.swift
//  vocard
//
//  Created by windowcow on 10/29/23.
//

import SwiftUI

struct OptionButton: View {
    @Binding var selectedOption: Int?
    let isScored: Bool
    let quiz: QuizDataModel
    let currentOptionNumber: Int
    var options: [String] {
        [quiz.choice1, quiz.choice2, quiz.choice3, quiz.choice4]
    }

    var body: some View {
        HStack {
            Button {
                selectedOption = currentOptionNumber
            } label: {
                Text(options[currentOptionNumber - 1])
                    .foregroundStyle(.black)
                    .frame(width: 282 , height: 62)
                    .background(.quizOption, in: .rect(cornerRadius: 15))
                    .optionStyle(answer: quiz.answer,
                                 currentOption: currentOptionNumber, 
                                 selectedOption: $selectedOption,
                                 isScored: isScored)
            }

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
        self.modifier(OptionModifier(answer: answer, 
                                     currentOption: currentOption,
                                     selectedOption: selectedOption,
                                     isScored: isScored))
    }
}

///  Option Modifier <<<


//#Preview {
//    ZStack {
//        Color.black
//        CardQuizView(quiz: Quiz.example)
//            
//
//    }
//}
