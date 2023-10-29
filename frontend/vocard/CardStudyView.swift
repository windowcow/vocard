//
//  ContentView.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI
import SwiftData

struct CardStudyView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("TODAY'S WORD")
                        .font(.title2)
                    Text("128")
                        .font(.title2)
                        .fontWeight(.heavy)
                }
                Spacer()
                Button(action: {}){
                    Text("MENU")
                        .padding([.horizontal])
                        .padding([.vertical], 8)
                        .foregroundStyle(.black)
                        .background(.white, in: .rect(cornerRadius: 20))
                }
            }
            .padding(.top, 30)
            Divider()
                .background(.white)
            
            
            CardDontKnowView'(
                cardData: CardData.example
            )
            .padding()
            .padding(.vertical)
        }
        .background(.black)
        .foregroundStyle(.white)

    }
}

#Preview {
    CardStudyView()
}
