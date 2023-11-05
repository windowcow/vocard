//
//  CardDetailEditView.swift
//  vocard
//
//  Created by windowcow on 11/3/23.
//

import SwiftUI


struct CardDetailAddView: View {
    @State var cardData: CardData
    @State var text: String = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer(minLength: 50)

                Text("\(cardData.originalWord)")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                VStack {
                    ZStack {
                        Image("DetailAddImage")
                            .resizable()
                            .scaledToFill()
                            .padding()
                        ProgressView()
                    }
                    
                    TextField("", text: $text)
                        .padding()
                        .background(.gray, in: .rect(cornerRadius: 10))
                    Text("VOCARD의 평가")
                    ProgressView()
                        .padding()
                        .frame(width: 350)
                        .background(.gray, in: .rect(cornerRadius: 10))

                }
                .background(Color("CardBackInsideColor"), in: .rect(cornerRadius: 15))
                .padding()
            }
            .foregroundStyle(.white)
            .background(Color.cardBackInside, in: .rect(cornerRadius: 15))
            .scaledToFit()
        }
    }
}

#Preview {
    CardDetailEditView(cardData: .example1)
}
