//
//  CardBackView.swift
//  vocard
//
//  Created by windowcow on 10/27/23.
//

import SwiftUI





struct CardDetailExampleImageSentenceView: View {
    @Environment(CurrentCard.self) var currentCard

    var body: some View {
        VStack(spacing: 20) {
            Image("SampleImage")
                .resizable()
                .frame(width: 200, height: 200)
            Text(currentCard.cardData.exampleSentence)
                .frame(width: 250)
        }
        .frame(width: 288, height: 279)
        .background(.cardBackInside, in: .rect(cornerRadius: 10))
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




//#Preview {
//    ZStack {
//        CardDetailView(cardData: CardData.example1)
//
////        CardDetailEditView(cardData: CardData.example)
//    }
//}
