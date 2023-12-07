//
//  SwiftUIView.swift
//  vocard
//
//  Created by windowcow on 12/7/23.
//

import SwiftUI
import SwiftData


struct CardGPTPage_Cell: View {
    @Bindable var studyMaterial: ChatData
    var my: String
    var gpt: String?
    var imageURL: String?
    @State var isImageBig: Bool = false
    @Namespace var cell
//    @Query var chatData: [ChatData]
    
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
            if let imageURL = imageURL {
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
                    Text(my)
                        .font(.caption)

                    HStack {
                        if let gptMessage = gpt {
                            Text(gptMessage)
                            
                            if let imageURL = imageURL {
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
                                Button("이미지 생성하기") {
                                    
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
    }
}
