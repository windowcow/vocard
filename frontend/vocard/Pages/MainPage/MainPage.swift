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
    var cardData: CardData?
    

}

struct MainPage: View {
    @Namespace var namespace
    @Environment(\.modelContext) private var modelContext
    @Query var allCards: [CardData]
    
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
                    .padding(.vertical)

                MainPage_Bottom_NextWord()
                    .frame(maxWidth: g.size.width * 0.9 ,
                           maxHeight: g.size.height * 0.4)
                    .padding(.vertical)

                    .matchedGeometryEffect(id: "card", in: namespace)
                
                Spacer()

            }
            .background(.black)

            
        }
        // geo end
        .environment(currentCard)
        .task {
            currentCard.cardData = allCards.getCard(unseenCardProb: 50)
        }
    }
}




#Preview {
    RootView()
        .background(.black)
        .foregroundStyle(.white)
        .modelContainer(sharedModelContainer)
}
