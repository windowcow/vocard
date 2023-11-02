//
//  CardQuizBottomButtonView.swift
//  vocard
//
//  Created by windowcow on 10/31/23.
//

import SwiftUI

struct CardStudyViewBottomView: View {
    let cardSide: CardSide
    
    var body: some View {
        HStack {
            switch cardSide {
            case .front:
                EmptyView()
            case .detail:
                CardDetailBottomButtonView()
            case .quiz:
                CardQuizBottomButtonView()
            case .detailEdit:
                EmptyView()
            }
        }
        .frame(width: .infinity,
               height: .infinity,
               alignment: .center)
    }
}

struct CardDetailBottomButtonView: View {
    var body: some View {
        HStack(spacing: 20) {
            Button {
                
            } label: {
                Text("NEXT")
                    .padding()
                    .background(.quizPassButton,
                                in: PassButtonShape())
                    .font(.title3)
                    .foregroundStyle(.white)
            }
        }
        .frame(width: .infinity, height: .infinity)
    }
}

struct CardQuizBottomButtonView: View {
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 20){
                Button {
                    // next card
                } label: {
                    Text("PASS")
                        .frame(width: geometry.size.width / 4)
                        .padding()
                        .background(.quizPassButton,
                                    in: PassButtonShape())
                        .font(.title3)
                        .foregroundStyle(.white)
                }
                
                Button {
                    // submit
                    
                } label: {
                    Text("SUBMIT")
                        .frame(width: geometry.size.width * 2 / 4)
                        .padding()
                        .background(.quizSubmitButton,
                                    in: SubmitButtonShape())
                        .font(.title3)
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    CardQuizBottomButtonView()
}
