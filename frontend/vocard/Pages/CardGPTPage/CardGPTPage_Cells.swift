//
//  CardGPTPage_StudyMateriCells.swift
//  vocard
//
//  Created by windowcow on 12/7/23.
//

import SwiftUI
import SwiftData

struct CardGPTPage_Cells: View {
    var headword: String
    @Query var studyMaterials: [ChatData]
    
    init(headword: String, meaning: MeaningData) {
        self.headword = headword

        _studyMaterials = Query(
            filter: ChatData.predicate(headword: headword)
        )
    }
    
    
    
    var body: some View {
        LazyVStack {
            ForEach(studyMaterials) { studyMaterial in
                CardGPTPage_Cell(studyMaterial: studyMaterial)
            }
        }
    }
}


struct CardGPTPage_TextField: View {
    var headword: String
    @State private var text: String = ""
    @Environment(\.modelContext) var modelContext
    var body: some View {
        HStack {
            TextField(text: $text) {
                
            }
            .frame(maxWidth: .infinity)
            Spacer()
            
            
            
            Button{
                let currentChatData = ChatData(headword: headword, myMessage: text)
                text = ""
                modelContext.insert(currentChatData)
                Task { @MainActor in
                    
                    
                }
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
//    
//    func getGPTMessage() async throws -> String {
//        
//    }
}
