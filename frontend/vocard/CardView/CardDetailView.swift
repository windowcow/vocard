//
//  CardBackView.swift
//  vocard
//
//  Created by windowcow on 10/27/23.
//

import SwiftUI

enum DefinitionType {
    case English, Korean
}
struct CardDetailView: View {
    let cardData: CardData
    @State private var definitionType: DefinitionType = .English

    
    var body: some View {
        ZStack {
            CardBackBackgroundView(backgroundColor: .cardBack)
            VStack(spacing: 20) {
                Color.clear
                    .frame(height: 25)
                CardWordTextView(cardData: .example, cardType: .detail)
                CardDetailDefinition(cardData: cardData,
                                     definitionType: $definitionType)
                CardDetailExampleImageSentenceView(cardData: cardData)
            }
        }
        .foregroundStyle(.white)
    }
}

struct CardDetailDefinition: View {
    let cardData: CardData
    @Binding var definitionType: DefinitionType
    
    var body: some View {
        Button {
            if definitionType == .English {
                definitionType = .Korean
            } else {
                definitionType = .English
            }
        } label: {
            Text(definitionType == .English ? cardData.englishDefinition : cardData.translatedWord)
                .frame(width: 288, height: 60)
                .background(.cardBackInside, in: .rect(cornerRadius: 10))
        }
    }
}

struct CardWordTextView: View {
    let cardData: CardData
    let cardType: CardSide
    
    var body: some View {
        Text(cardData.originalWord)
            .foregroundStyle(cardType == .front ? .black : .white)
            .font(.largeTitle)
            .fontWeight(.heavy)
    }
}

struct CardDetailExampleImageSentenceView: View {
    let cardData: CardData
    
    var body: some View {
        VStack(spacing: 20) {
            Image("SampleImage")
                .resizable()
                .frame(width: 200, height: 200)
            Text(cardData.exampleSentence)
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




#Preview {
    ZStack {
        CardDetailView(cardData: CardData.example)

//        CardDetailEditView(cardData: CardData.example)
    }
}
