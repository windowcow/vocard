//
//  CardDetailEditPage.swift
//  vocard
//
//  Created by windowcow on 12/7/23.
//

import Foundation
import SwiftUI
import SwiftData

struct CardDetailEditPage: View {
    @Bindable var card: CardData
    @Environment(\.dismiss) var dismiss
    
    @Query var cards: [CardData]
    
    var body: some View {
        ZStack {
            Color.white
            VStack{
                Button("x"){
                    dismiss()
                }
                Text(card.wordData.headWord)
                Text(card.wordData.wordMeaningDataModels.first?.meaning ?? "no")
            }
            
            
            LazyVStack {
                ForEach(card.wordData.wordMeaningDataModels) { meaning in
                    let _ = print(meaning.meaning)
                    CardDetailEditPage_Meaning(meaning: meaning)
                }
            }
            
        }
        .clipShape(.rect(cornerRadius: 15))
//        .task {
//            print(card)
//        }
    }
}


struct CardDetailEditPage_Meaning: View {
    @Bindable var meaning: MeaningData
    
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
//        .task {
//            print(meaning.meaning)
//        }
    }
}
