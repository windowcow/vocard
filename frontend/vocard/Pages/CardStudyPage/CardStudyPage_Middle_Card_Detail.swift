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
    
    
    var body: some View {
        CardBackgroundView(backgroundColor: .green)
            .overlay {
                ZStack {
                    Color.clear
                    VStack {
                        StarView(starCount: currentCard.cardData?.currentStarCount ?? .zero)
                            .padding(.top)
                            .foregroundStyle(.yellow)
                        (
                        Text(currentCard.cardData?.wordData.headword ?? "example")
                            .font(.largeTitle)
                            .bold() +
                        Text("\(currentCard.cardData?.wordData.senseNum ?? 1)")
                            .font(.caption)
                            .baselineOffset(8) +
                        Text("   ") +
                        Text(currentCard.cardData?.wordData.pos ?? "verb")
                        )
                        .padding(.top)
                        
                        Text(currentCard.cardData?.wordData.meaningDatas.first?.meaning ?? "To go")
                            .padding(.horizontal)
                        Spacer()
                        VStack {
                            AsyncImage(url: currentCard.cardData?.wordData.meaningDatas.first?.exampleSentences.first?.illustrations.first?.imageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .padding(30)
                                    .shadow(radius: 0)
                            } placeholder: {
                                ProgressView()
                            }

                            Text(currentCard.cardData?.wordData.meaningDatas.first?.exampleSentences.first?.sentence ?? "I like apple")
                        }
                        
                        .compositingGroup()
                        .shadow(radius: 10)

                        .foregroundStyle(.white)
                        .padding()
//                        .background(.white, in: .rect(cornerRadius: 10))
                        .padding()
                        Spacer()
                    }
                
                }
                .foregroundStyle(.white)
            }
    }
}



#Preview {
    MainPage()
        .modelContainer(sharedModelContainer)
}
