//
//  SwiftUIView.swift
//  vocard
//
//  Created by windowcow on 12/7/23.
//

import SwiftUI


struct CardGPTPage_Cell: View {
    var studyMaterial: ChatData
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
            VStack(alignment: .leading) {
                Text("me: ") +
                Text(studyMaterial.myMessage)
                    .font(.caption)

                HStack {
                    if let gptMessage = studyMaterial.gptMessage {
                        Text(gptMessage)
                        
                        if let imageURL = studyMaterial.imageURL {
                            
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
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 1)
        }
    }
}
