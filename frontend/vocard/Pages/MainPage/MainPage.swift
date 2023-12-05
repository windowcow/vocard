//
//  MainPage.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/1/23.
//
import SwiftUI
import SwiftData
import Charts

@Observable class CurrentCard {
    var currentCard: CardDataModel?
}

struct MainPage: View {
    @State private var a = 0
    @Namespace var namespace
    @Query var allCards: [CardDataModel]
    @State private var currentCard: CurrentCard = CurrentCard()
    @State private var isCardStudyPagePresented = false

    var body: some View {
        GeometryReader { g in
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

            
        }
        // geo end
        .animation(.bouncy, value: a)
        .task {
            currentCard.currentCard = allCards.getCard(unseenCardProb: 50)
            print(currentCard.currentCard?.targetWordDataModel.headWord)
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
