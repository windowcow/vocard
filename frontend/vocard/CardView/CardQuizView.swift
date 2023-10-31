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
    @State private var selectedOption: Int?

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
                        
                    } label: {
                        Text(quiz.choice1)
                            .customButtonStyle(geo: geo)
                    }
                    Button{
                        
                    } label:  {
                        Text(quiz.choice2)
                            .customButtonStyle(geo: geo)
                    }
                    Button {
                        
                    } label: {
                        Text(quiz.choice3)
                            .customButtonStyle(geo: geo)
                    }
                    Button {
                        
                    } label: {
                        Text(quiz.choice4)
                            .customButtonStyle(geo: geo)
                    }
                }
                .foregroundStyle(.black)
                
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
#Preview {
    ZStack {
        Color.black
        CardQuizView(quiz: Quiz.example)
            

    }
}
