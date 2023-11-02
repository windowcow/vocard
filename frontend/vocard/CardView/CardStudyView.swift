//
//  ContentView.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI
import SwiftData


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
    @State private var cardSide: CardSide = .front

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    CardStudyViewTop()
                        .padding(.horizontal)
                        .foregroundStyle(.white)
                        .frame(width: geo.size.width,
                               height: geo.size.height / 10)
                    Divider()
                    Spacer()

                        .background(.white)
                    
                    CardView(cardSide: $cardSide)
                        .frame(width: geo.size.width * 9 / 10,
                               height: geo.size.height * 3 / 4,
                               alignment: .center)
                    
                    Spacer()
                    
                    CardStudyViewBottomView(cardSide: cardSide)
                        .frame(width: geo.size.width,
                               height: geo.size.height / 3)
                    
                }
                .frame(width: .infinity,
                       height: .infinity)
            }
        }
        

    }
}

#Preview {
    CardStudyView()
}
