//
//  CardStudyPage_Middle_Card_Detail.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI
import SwiftData

struct StarView: View {
    let starCount: CardData.CurrentStarCount
    var body: some View {
        switch starCount {
        case .zero:
            Text(Image(systemName: "star")) +
            Text(Image(systemName: "star")) +
            Text(Image(systemName: "star")) +
            Text(Image(systemName: "star")) +
            Text(Image(systemName: "star"))
        case .one:
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star")) +
            Text(Image(systemName: "star")) +
            Text(Image(systemName: "star")) +
            Text(Image(systemName: "star"))
        case .two:
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star")) +
            Text(Image(systemName: "star")) +
            Text(Image(systemName: "star"))
        case .three:
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star")) +
            Text(Image(systemName: "star"))
        case .four:
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star"))
        case .max:
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star.fill")) +
            Text(Image(systemName: "star.fill"))
        }
    }
}

struct CardStudyPage_Middle_Card_Detail: View {
    @Environment(CurrentCard.self) var currentCard
    @Environment(\.modelContext) private var modelContext
    
    @Query var quiz: [QuizData]
    
    var body: some View {
        CardBackgroundView(backgroundColor: .green)
            .overlay {
                ZStack {
                    Color.clear
                    VStack {
                        StarView(starCount: currentCard.cardData?.currentStarCount ?? .zero)
                        Text(currentCard.cardData?.wordData.headword ?? "example")
                            .font(.largeTitle)
                            .bold()
                        Text(currentCard.cardData?.wordData.meaningDatas.first?.meaning ?? "To go")
                        VStack {
//                            Image(currentCard.cardData?.wordData.meaningDatas.first?.exampleSentences.first?.illustrations.first?.imageURL ?? SampleImage)
                            Image("sampleImage")
                                .resizable()
                                .scaledToFit()
                                .padding(30)
                                .shadow(radius: 0)
                            Text(currentCard.cardData?.wordData.meaningDatas.first?.exampleSentences.first?.sentence ?? "I like apple")
                        }
                        
                        .compositingGroup()
                        .shadow(radius: 10)

                        .foregroundStyle(.white)
                        .padding()
//                        .background(.white, in: .rect(cornerRadius: 10))
                        .padding()
                    }
                
                }
                .foregroundStyle(.white)
            }
            .task {
                print(quiz.debugDescription)
            }
    }
}



#Preview {
    MainPage()
        .modelContainer(sharedModelContainer)
}
