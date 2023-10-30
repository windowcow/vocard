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


struct CardQuizView: View {
    let quiz: Quiz

    var body: some View {
        VStack {
            HStack {
                Text("Q")
                    .font(.largeTitle)
                    .bold()
                Text(quiz.question)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text(quiz.choice1)
                Text(quiz.choice2)
                Text(quiz.choice3)
                Text(quiz.choice4)
            }
        }
        .padding()
        .background(.white, in: CardBackShape())
    }
}


#Preview {
    ZStack {
        Color.black
        CardQuizView(quiz: Quiz.example)
            

    }
}
