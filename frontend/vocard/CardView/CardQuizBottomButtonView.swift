//
//  CardQuizBottomButtonView.swift
//  vocard
//
//  Created by windowcow on 10/31/23.
//

import SwiftUI

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
