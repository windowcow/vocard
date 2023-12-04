//
//  MainPage_CardStudyView.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import SwiftUI
import SwiftData

struct CardStudyPage: View {
    @Environment(CardDataModel.self) var currentCard: CardDataModel?
    @State private var cardStudyPageViewModel: CardStudyPageViewModel = CardStudyPageViewModel()
    var body: some View {
        ZStack {
            Color.clear
            VStack {
                CardStudyPage_Top()
                CardStudyPage_Middle()
                CardStudyPage_Bottom()
            }
            .environment(cardStudyPageViewModel)
        }
    }
}




#Preview {
    MainPage()
        .modelContainer(sharedModelContainer)
        .background(.black)
}
