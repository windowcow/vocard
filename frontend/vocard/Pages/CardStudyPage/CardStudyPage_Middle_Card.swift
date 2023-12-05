//
//  CardStudyPage_Middle_Card.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI

struct CardStudyPage_Middle_Card: View {
    @Environment(CardDataModel.self) var currentCard: CardDataModel?
    @State private var vm: CardStudyPageViewModel = CardStudyPageViewModel()
    @Binding var cardViewStatus: CardViewStatus
    
    var body: some View {
        switch cardViewStatus {
        case .front:
            CardStudyPage_Middle_Card_Front(headword: currentCard?.targetWordDataModel.headWord ?? "Apple")
                .environment(vm)
                .movable(vm, $cardViewStatus)
        case .detail:
            CardStudyPage_Middle_Card_Detail()
        case .quiz:
            CardStudyPage_Middle_Card_Quiz()
        }
    }
}

#Preview {
    MainPage()
}
