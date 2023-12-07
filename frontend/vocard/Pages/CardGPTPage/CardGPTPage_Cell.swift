//
//  SwiftUIView.swift
//  vocard
//
//  Created by windowcow on 12/7/23.
//

import SwiftUI


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
