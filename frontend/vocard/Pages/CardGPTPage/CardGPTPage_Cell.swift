//
//  SwiftUIView.swift
//  vocard
//
//  Created by windowcow on 12/7/23.
//

import SwiftUI
import SwiftData


struct CardGPTPage_Cell: View {
    var studyMaterial: ChatData
    @State var isImageBig: Bool = false
    @Namespace var cell
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
            if let imageURL = studyMaterial.imageURL, isImageBig {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(30)
                        .shadow(radius: 0)
                        .onTapGesture {
                            isImageBig.toggle()
                        }
                        
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(1, contentMode: .fit)
                .padding()
                .onTapGesture {
                    isImageBig.toggle()
                }
                .matchedGeometryEffect(id: "image", in: cell)
            } else {
                VStack(alignment: .leading) {
                    Text("me: ") +
                    Text(studyMaterial.myMessage)
                        .font(.caption)
                    Divider()
                    HStack {
                        if let gptMessage = studyMaterial.gptMessage {
                            Text(gptMessage)
                            
                            if let imageURL = studyMaterial.imageURL {
                                if imageURL == "" {
                                    ProgressView()
                                } else {
                                    AsyncImage(url: URL(string: imageURL)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .padding(30)
                                            .shadow(radius: 0)
                                            .onTapGesture {
                                                isImageBig.toggle()
                                            }
                                            
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .matchedGeometryEffect(id: "image", in: cell)
                                }
                                
                            } else {
                                Button {
                                    Task { @MainActor in
                                        let gptResponse = try? await getGPTImage(style: "", sentence: studyMaterial.myMessage)
                                        studyMaterial.imageURL = gptResponse

                                    }
                                    studyMaterial.imageURL = ""
                                } label: {
                                    Text(Image(systemName: "photo.badge.plus.fill"))
                                        .font(.largeTitle)
                                }
                            }
                        } else {
                            EmptyView()
                        }
                    }
                }
            }
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 1)
        }
        .padding()
        .animation(.bouncy, value: isImageBig)
    }
    
    func getGPTImage(style: String, sentence: String) async throws -> String {
        let endpoint = URL(string: "http://13.210.45.211/ai/img/")!
        let json: [String:String] = ["style" : style, "sentence": sentence]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        
        let (d, r) = try await URLSession.shared.data(for: request)
        print(d)
        print(r)
        
        if let response = try? JSONDecoder().decode([String:String].self, from: d) {
            return response["img_url"] ?? "Error"
        } else {
            return "ERROR"
        }
        
    }
}
