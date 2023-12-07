//
//  CardGPTPage.swift
//  vocard
//
//  Created by windowcow on 12/7/23.
//

import SwiftUI
import SwiftData

struct CardGPTPage: View {
    var headword: String
    var meaning: MeaningData
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
            VStack {
                HStack {
                    VStack {
                        (
                        Text(meaning.wordData?.headword ?? headword)
                            .font(.largeTitle)
                            .bold() +
                        Text("\(meaning.wordData?.senseNum ?? 1)")
                            .baselineOffset(8)
                        )
                        Text(meaning.wordData?.pos ?? "verb")
                            .font(.caption)
                            .padding(.bottom)
                        
                    }
                    Spacer()

                    Button("x") {
                        dismiss()
                    }
                    .padding(.trailing)
                }
                (Text("\(meaning.meaningNum)") + Text(". ") + Text(meaning.meaning))
                    .foregroundStyle(.black)
                
                /// 사용자 - gpt 평가가 여기 저장됨. ForEach로 구현 예정
                Divider()
                
                CardGPTPage_Cells(meaning: meaning)
                
                
                Spacer()
                CardGPTPage_TextField()
                    .padding(.bottom)
            }
            
        }
        .padding()
    }
}

@Model class StudyMaterial {
    var sourceMeaning: MeaningData
    var myMessage: String = ""
    var gptMessage: String = ""
    var imageURL: URL?
    
    init(sourceMeaning: MeaningData, myMessage: String, gptMessage: String, imageURL: URL? = nil) {
        self.sourceMeaning = sourceMeaning
        self.myMessage = myMessage
        self.gptMessage = gptMessage
        self.imageURL = imageURL
    }
}

struct CardGPTPage_Cells: View {
    var meaning: MeaningData
    
    var body: some View {
        LazyVStack {
            
        }
    }
}

struct CardGPTPage_Cell: View {
    
    
    var body: some View {
        ZStack {
            Color.clear
            HStack {
                VStack {
                    
                }
                
                ///AsyncImage
            }
        }
    }
}

struct CardGPTPage_TextField: View {
    @State private var text: String = ""
    var body: some View {
        HStack {
            TextField(text: $text) {
                
            }
            .frame(maxWidth: .infinity)
            Spacer()
            
            
            
            Button{
                
            } label: {
                Image(systemName: "arrow.up")
            }
            
        }
        .padding()
        .overlay {
            Capsule()
                .stroke(.blue, lineWidth: 2)
        }
    }
}
//
//#Preview {
//    CardGPTPage()
//}
