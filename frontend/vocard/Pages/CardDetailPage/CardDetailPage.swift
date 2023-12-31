//
//  CardDetailEditPage.swift
//  vocard
//
//  Created by windowcow on 12/7/23.
//

import Foundation
import SwiftUI
import SwiftData

enum CardDetailPageType {
    case dictionary, custom
}

struct CardDetailPage_ExampleView: View {
    var example: ExampleData
    
    var body: some View {
        VStack {
            Text(example.sentence)
                .font(.caption)
                .frame(idealWidth: 500)
            

            ForEach(example.illustrations) { illust in
                AsyncImage(url: illust.imageURL){ image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(30)
                        .shadow(radius: 0)
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}
struct CardDetailPage_MeaningView: View {
    @State private var isGPTPagePresented: Bool = false
    var word: WordData
    
    var body: some View {
        List {
            ForEach(word.meaningDatas, id: \.id) { meaning in
                VStack(alignment: .leading) {
                    (Text("\(meaning.meaningNum)") + Text(". ") + Text(meaning.meaning))
                        .foregroundStyle(.black)
                    VStack {
                        ForEach(meaning.exampleSentences) { example in
                            CardDetailPage_ExampleView(example: example)
                                
                        }
                    }
                }
                .fullScreenCover(isPresented: $isGPTPagePresented, content: {
                
                    CardGPTPage(headword: word.headword,meaning: meaning)
                })
                .swipeActions(edge: .trailing) {
                    Button {
                        isGPTPagePresented.toggle()
                    } label: {
                        Label("Study", systemImage: "pencil.and.scribble")
                    }
                    .tint(.blue)
                    
                }
            }
        }
        
    }
}
struct CardDetailPage: View {
    @Environment(\.dismiss) var dismiss
    
    @Query var words: [WordData]
    @State var cardDetailPageType: CardDetailPageType = .dictionary
    
    init(headword: String) {
        _words = Query(filter: WordData.predicate(headword: headword))
    }
    
    
    var body: some View {
        if let word = words.first {
            ZStack(alignment: .top) {
                Color.white
                VStack{
                    HStack {
                        Spacer()
                        Button("x"){
                            dismiss()
                        }
                    }
                    HStack {
                        
                        Text(word.headword)
                            .font(.largeTitle)
                            .bold()
                            .padding(.leading)
                        Text("\(word.senseNum)").baselineOffset(8)
                        Text(word.pos)
                            .font(.caption)
                        Spacer()
                    }
                    
                    
                    
                    switch cardDetailPageType {
                    case .dictionary:
                        CardDetailPage_MeaningView(word: word)

                    case .custom:
                        VStack{
                            
                        }
                    }
                    
                    
                    
                }
            }
        } else {
            ZStack{
                Text("No Meanings")
            }
        }
    
            
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
