//
//  CardsPage_Middle_CardView.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI

struct CardsPage_Middle_CardView: View {
    @Bindable var card: CardDataModel
    @State private var isCardsPage_CardView_Detail_Presented = false
    
    var body: some View {
        ZStack {
            Color.clear
            Text(card.targetWordDataModel.headWord)
                .foregroundStyle(.white)

        }
        .background(.gray.gradient)
        .clipShape(.rect(cornerRadius: 15))
        .aspectRatio(0.66, contentMode: .fit)
        .overlay {
            VStack {
                StarView(starCount: card.currentStarCount ?? .zero)
                    .font(.caption)
                    .foregroundStyle(.yellow)
                    .padding(.top)
                Spacer()
            }
        }
        .contentShape(.rect)
        .onTapGesture {
            isCardsPage_CardView_Detail_Presented.toggle()
        }
        .fullScreenCover(isPresented: $isCardsPage_CardView_Detail_Presented) {
            CardDetailEditPage(card: card)
        }
    }
}

struct CardDetailEditPage: View {
    @Bindable var card: CardDataModel
    var body: some View {
        ZStack {
            Color.white
            Text("gg")
            LazyVStack {
                ForEach(card.targetWordDataModel.wordMeaningDataModels, id: \.self) { meaning in
                    CardDetailEditPage_Meaning(meaning: meaning)
                }
            }
            
        }
        .clipShape(.rect(cornerRadius: 15))
        .task {
            print(card)
        }
    }
}

struct CardDetailEditPage_Meaning: View {
    @Bindable var meaning: MeaningDataModel
    
    var body: some View {
        ZStack {
            Color.brown
            HStack {
                VStack {
                    Text("\(meaning.meaningNum)") +
                    Text(meaning.meaning)
                    Text(meaning.exampleSentences.first?.sentence ?? "example sentence")
                }
                AsyncImage(url: meaning.exampleSentences.first?.illustrations.first?.imageURL)
                    .scaledToFit()
            }
        }
        .task {
            print(meaning.meaning)
        }
    }
}

#Preview {
    CardsPage()
        .modelContainer(sharedModelContainer)
}
