//
//  CardDetailEditPage.swift
//  vocard
//
//  Created by windowcow on 12/7/23.
//

import Foundation
import SwiftUI

struct CardDetailEditPage: View {
    @Bindable var card: CardData
    var body: some View {
        ZStack {
            Color.white
            Text("gg")
            LazyVStack {
                ForEach(card.wordData.wordMeaningDataModels, id: \.self) { meaning in
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
