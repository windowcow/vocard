//
//  CardStudyPage_Middle_Card.swift
//  vocard
//
//  Created by windowcow on 12/4/23.
//

import SwiftUI

struct CardStudyPage_Middle_Card: View {
    @Environment(CardDataModel.self) var currentCard: CardDataModel?
    @State private var cardViewStatus: CardViewStatus = .front(.middle)
    
    var body: some View {
        switch cardViewStatus {
        case .front:
            CardStudyPage_Middle_Card_Front(                                            currentCardStatus: $cardViewStatus, headword: currentCard?.targetWordDataModel.headWord ?? "Apple")
//                .onPreferenceChange(CardViewStatusPreferenceKey.self) {newValue in
//                cardViewStatus = newValue
//            }

        case .back(let cardBackStatus):
            switch cardBackStatus {
            case .detail:
                CardStudyPage_Middle_Card_Detail()
            case .quiz:
                CardStudyPage_Middle_Card_Quiz()
            }
        }
    }
}

#Preview {
    CardStudyPage_Middle_Card()
}
