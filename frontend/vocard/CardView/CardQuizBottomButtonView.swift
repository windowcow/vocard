//
//  CardQuizBottomButtonView.swift
//  vocard
//
//  Created by windowcow on 10/31/23.
//

import SwiftUI

struct CardQuizBottomButtonView: View {
    var body: some View {
        GeometryReader { geo in
            HStack {
                Button(action: {}) {
                    Text("PASS")
                        .frame(width: geo.size.width / 13 * 4, height: geo.size.height / 3 * 2 )

                        .background(.quizPassButton,
                                    in: PassButtonShape())
                        .font(.title3)
                        .foregroundStyle(.white)
                }
                Spacer()
                Button(action: {}) {
                    Text("SUBMIT")
                        .frame(width: geo.size.width / 13 * 8, height: geo.size.height / 3 * 2 )

                        .background(.quizSubmitButton,
                                    in: SubmitButtonShape())
                        .font(.title3)
                        .foregroundStyle(.black)

                }
            }
            .background(.clear, in: .rect)
        }
    }
}

#Preview {
    CardQuizBottomButtonView()
}
