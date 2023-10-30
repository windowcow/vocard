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
        GeometryReader { geo in
            VStack {
                HStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("-> 3 TIMES")
                    

                    Spacer()

                }
                .padding(.vertical)
                
                HStack {
                    Text("Q")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading)
                    Text(quiz.question)
                    Spacer()
                }
                .frame(width: geo.size.width)
                .padding()
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Button(action: {}) {
                        Text(quiz.choice1)
                            .frame(width: geo.size.width * 8 / 9, height: geo.size.height / 15)
                            .background(.gray, in: RoundedRectangle(cornerRadius: 10))
                    }
                    Button(action: {}) {
                        Text(quiz.choice2)
                            .frame(width: geo.size.width * 8 / 9, height: geo.size.height / 15)
                            .background(.gray, in: RoundedRectangle(cornerRadius: 10))
                    }
                    Button(action: {}) {
                        Text(quiz.choice3)
                            .frame(width: geo.size.width * 8 / 9, height: geo.size.height / 15)
                            .background(.gray, in: RoundedRectangle(cornerRadius: 10))
                    }
                    Button(action: {}) {
                        Text(quiz.choice4)
                            .frame(width: geo.size.width * 8 / 9, height: geo.size.height / 15)
                            .background(.gray, in: RoundedRectangle(cornerRadius: 10))
                    }
                }
                .foregroundStyle(.black)
                
                Spacer()

            }
            .padding()

            .frame(width: geo.size.width,
                   height: geo.size.height)
            .background(.white, in: CardBackShape())
            
        }
        
    }
}


#Preview {
    ZStack {
        Color.black
        CardQuizView(quiz: Quiz.example)
            

    }
}
