//
//  MainPage_CardStudyView.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import SwiftUI
import SwiftData

extension CurrentCard: Equatable {
    static func == (lhs: CurrentCard, rhs: CurrentCard) -> Bool {
        lhs.cardData == rhs.cardData
    }
}
struct CardStudyPage: View {
    @State private var cardStudyPageViewModel: CardStudyPageViewModel = CardStudyPageViewModel()
    @Environment(CurrentCard.self) private var currentCard
    var body: some View {
        ZStack {
            Color.black
                .geometryGroup()
                .ignoresSafeArea()

            VStack {
                CardStudyPage_Top()
                    .padding(.horizontal)
                CardStudyPage_Middle()
                    .padding()
                CardStudyPage_Bottom()
                    .padding(.horizontal)
                    .controlSize(.extraLarge)


            }
            .environment(cardStudyPageViewModel)
            .onChange(of: currentCard) { oldValue, newValue in
                cardStudyPageViewModel.refresh()
            }
        }
    }
}




#Preview {
    MainPage()
        .modelContainer(sharedModelContainer)
        .background(.black)
}
