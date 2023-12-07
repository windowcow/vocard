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
    
    @State private var cardProb = Probability(probability: 30)

    var body: some View {
        GeometryReader { g in
            VStack {
                MainPage_Top()
                    .environment(cardProb)
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
                    .environment(cardProb)

                Spacer()
                
                VStack {
                    Slider(value: Binding(get: {
                        Double(cardProb.probability)
                    }, set: { value in
                        cardProb.probability = Int(value)
                    }),
                           in: 1...99
                    ) {
                        Text("")
                    } minimumValueLabel: {
                        Text("1%")
                    } maximumValueLabel: {
                        Text("99%")

                    }
                    .padding(.horizontal)
                    Text("New Card: \(cardProb.probability)%")
                        .foregroundStyle(.white)
                }
                
                .padding(.bottom)


            }
            .background(.black)

            
        }
        // geo end
        .environment(currentCard)
        .task {
            currentCard.cardData = allCards.getCard(unseenCardProb: cardProb.probability)
        }
    }
}




#Preview {
    RootView()
        .background(.black)
        .foregroundStyle(.white)
        .modelContainer(sharedModelContainer)
}
