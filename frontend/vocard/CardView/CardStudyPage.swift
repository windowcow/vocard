//
//  ContentView.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI
import SwiftData



struct CardStudyPage: View {
    @State private var cardSide: CardSide = .front

    var body: some View {
        ZStack {
            Color.mainBgr
                .ignoresSafeArea()
            VStack {
                CardStudyPageTop()
                Spacer()
                CardStudyPageMiddle(cardSide: $cardSide)
                    .shadow(color: .gray,
                            radius: 20,
                            x: 0.0,
                            y: 0.0)
                Spacer()
                CardStudyPageBottom(cardSide: cardSide)
            }
        }
    }
}

struct CardStudyPageTop: View {
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
            .padding(.horizontal)
            Divider()
                .background(.white)
        }
        .foregroundStyle(.white)
    }
    
}

struct CardStudyPageBottom: View {
    let cardSide: CardSide
    var body: some View {
        switch cardSide {
        case .front:
            EmptyView()
        case .detail:
            Button {
                
            } label: {
                Text("NEXT")
                    .foregroundStyle(.white)
                    .frame(width: 330, height: 63, alignment: .center)
                    .background(.cardBack, in: NextButtonShape())
                
            }
        case .quiz:
            Button {
                
            } label: {
                HStack(spacing: 23) {
                    Text("PASS")
                        .foregroundStyle(.white)
                        .frame(width: 107, height: 63, alignment: .center)
                        .background(.cardBack, in: PassButtonShape())
                    Text("SUBMIT")
                        .foregroundStyle(.black)
                        .frame(width: 200, height: 63, alignment: .center)
                        .background(.quizSubmitButton, in: NextButtonShape())

                }
                
            }
        }
        
    }
}

#Preview {
    CardStudyPage()
}
