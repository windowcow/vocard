//
//  MainPage.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/1/23.
//
import SwiftUI
import SwiftData
import Charts


struct MainPage: View {
    @State private var a = 0
    @Namespace var namespace
    @Query var allCards: [CardDataModel]
    @State private var currentCard: CardDataModel?

    var body: some View {
        GeometryReader { g in
            switch a {
            case 0:
                VStack {
                    MainPage_Top()
                        .frame(maxHeight: g.size.height * 0.1)
                    Spacer()
                    MainPage_Middle()
                        .frame(maxWidth: g.size.width * 0.9,
                               maxHeight: g.size.height * 0.2)

                    Spacer()
                    MainPage_Bottom_NextWord(a: $a)
                        .frame(maxWidth: g.size.width * 0.9 ,
                               maxHeight: g.size.height * 0.4)
                    
                        .matchedGeometryEffect(id: "card", in: namespace)
                    
                    Spacer()
 
                }
                .background(.black)
            default:
                CardStudyPage()
                    .background(.black)
                .matchedGeometryEffect(id: "card", in: namespace)
            }
            
        }
        // geo end
        .animation(.bouncy, value: a)
        .task {
            currentCard = allCards.getCard(unseenCardProb: 50)
        }
        .environment(currentCard)
    }
}




#Preview {
    RootView()
        .background(.black)
        .foregroundStyle(.white)
        .modelContainer(sharedModelContainer)
}
