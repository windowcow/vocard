//
//  CardStudyPage_Middle_Card_Detail.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI



struct CardStudyPage_Middle_Card_Detail: View {
    @Environment(CardDataModel.self) var currentCard: CardDataModel?
    
    var body: some View {
        CardBackgroundView(backgroundColor: .green)
            .overlay {
                ZStack {
                    Color.clear
                    VStack {
                        Text(currentCard?.targetWordDataModel.headWord ?? "")
                            .font(.largeTitle)
                            .bold()
                        Text(currentCard?.targetWordDataModel.wordMeaningDataModels.first?.meaning ?? "To go")
                    }
                
                }
                .foregroundStyle(.white)
            }
    }
}



#Preview {
    MainPage()
        .modelContainer(sharedModelContainer)
}
