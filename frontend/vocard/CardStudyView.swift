//
//  ContentView.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI
import SwiftData

enum CardStudyViewBottomType {
    case front, detail, quiz
}

struct CardStudyViewTop: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("TODAY'S WORD")
                    .font(.title2)
                Text("128")
                    .font(.title2)
                    .fontWeight(.heavy)
            }
            .fixedSize(horizontal: false,
                       vertical: true)
            Spacer()
            Button(action: {}){
                Text("MENU")
                    .padding([.horizontal])
                    .padding([.vertical], 8)
                    .foregroundStyle(.black)
                    .background(.white, in: .rect(cornerRadius: 20))
            }
        }
    }
    
}

struct CardStudyView: View {
    var body: some View {
        VStack {
            
            CardStudyViewTop()
                .padding(.horizontal)
            
            Divider()
                .background(.white)
            
            CardDontKnowView(
                cardData: CardData.example
            )
            .padding()
        }
        .background(.black)
        .foregroundStyle(.white)

    }
}

#Preview {
    CardStudyView()
}
