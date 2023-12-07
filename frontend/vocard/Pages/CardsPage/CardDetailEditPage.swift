//
//  CardDetailEditPage.swift
//  vocard
//
//  Created by windowcow on 12/7/23.
//

import Foundation
import SwiftUI
import SwiftData

extension WordData {
    static func predicate(
        headword: String
    ) -> Predicate<WordData> {
        return #Predicate<WordData> { word in
            word.headword == headword
        }
    }
}

extension MeaningData {
    static func predicate(
        headword: String
    ) -> Predicate<MeaningData> {
        return #Predicate<MeaningData> { meaning in
            if let word = meaning.wordData {
                word.headword == headword
            } else {
                false
            }
        }
    }
}

struct CardDetailEditPage: View {
    @Environment(\.dismiss) var dismiss
    
    @Query var meanings: [MeaningData]
    
    init(headword: String) {
        _meanings = Query(filter: MeaningData.predicate(headword: headword))
    }
    
    
    var body: some View {
        ZStack {
            Color.white
            VStack{
                Button("x"){
                    dismiss()
                }
            }
            
            
            LazyVStack {
                ForEach(meanings) { meaning in
                    Text(meaning.meaning)
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
