//
//  CardBackView.swift
//  vocard
//
//  Created by windowcow on 10/27/23.
//

import SwiftUI

struct CardDetailView: View {
    @State var cardData: CardData
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Text("SCORE  **\(cardData.learningScore)**")
                    .font(.title3)
                    .position(x: geo.size.width * 3 / 4,
                              y: geo.size.height / 20)
                VStack {
                    Text("\(cardData.originalWord)")
                        .font(.largeTitle)
                        .bold()
                        .position(x: geo.size.width / 2,
                                  y: geo.size.height / 5)
    
                    Text("\(cardData.englishDefinition)")
                        .padding()
                        .background(Color("CardBackInsideColor"), in: .rect(cornerRadius: 15))
                        .padding()
                    
                    VStack {
                        Image("SampleImage")
                            .resizable()
                            .scaledToFill()
                            .padding()
                        Text("\(cardData.exampleSentence)")
                            .padding()
                    }
                    .background(Color("CardBackInsideColor"), in: .rect(cornerRadius: 15))                    .padding()
                    
                }
            }
            .background(Color.cardBack ,
                        in: CardBackShape())
            .foregroundStyle(.white)
        }
    }
}
struct CardDetailExample: View {
    @State var cardData: CardData

    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer(minLength: 50)

                Text("\(cardData.originalWord)")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                VStack {
                    Image("SampleImage")
                        .resizable()
                        .scaledToFill()
                        .padding()
                    Text("\(cardData.exampleSentence)")
                }
                .background(Color("CardBackInsideColor"), in: .rect(cornerRadius: 15))
                .padding()
                Spacer()
                Button{} label: {
                    Text("이 예문으로 설정하기")
                        .foregroundStyle(.black)
                        .padding()
                        .background(.white, in: .rect(cornerRadius: 15))
                }
                Spacer(minLength: 50)
            }
            .foregroundStyle(.white)
            .background(Color.cardBackInside, in: .rect(cornerRadius: 15))
            .scaledToFit()
        }
    }
}

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

struct CardDetailEditView: View {
    @State var cardData: CardData

    var body: some View {
        ScrollView([.horizontal]) {
            HStack(alignment: .center) {
                CardDetailExample(cardData: cardData)
                    .containerRelativeFrame(.horizontal, count: 2, span: 2, spacing: 10, alignment: .center)
                    .scrollTargetBehavior(.paging)
                CardDetailAddView(cardData: cardData)
                    .containerRelativeFrame(.horizontal, count: 2, span: 2, spacing: 10, alignment: .center)
                    .scrollTargetBehavior(.paging)

            }
        }
        .scrollTargetBehavior(.paging)

        
    }
}

#Preview {
    ZStack {
//        CardDetailView(cardData: CardData.example)

        CardDetailEditView(cardData: CardData.example)
    }
}
