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
    var meaning: String

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
                var gptResponse: String?
                Task {
                    gptResponse = try? await getGPTMessage(word: headword, dfn: meaning, sentence: text)
                }
                print(gptResponse)
                currentChatData.gptMessage = gptResponse
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
    
    func getGPTMessage(word: String, dfn: String, sentence: String) async throws -> String {
        let endpoint = URL(string: "http://13.210.45.211/ai/eval/")!
        let json: [String:String] = ["word" : word, "dfn": dfn, "sentence": sentence]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        var response: String? = nil
        
        let (d, r) = try await URLSession.shared.data(for: request)
        
        response = try? JSONDecoder().decode(String.self, from: d)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print("error in gptmessage")
//            }
//            
//            response = try? JSONDecoder().decode(String.self, from: data)
//        }
        
        return response ?? "Error"
    }
}
