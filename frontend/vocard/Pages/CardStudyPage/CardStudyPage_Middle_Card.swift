//
//  CardStudyPage_Middle_Card.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI

struct CardStudyPage_Middle_Card: View {
    @Environment(CurrentCard.self) var currentCard
    @Environment(CardStudyPageViewModel.self) var vm: CardStudyPageViewModel
    

    var body: some View {
        switch vm.cardViewStatus {
        case .front(let frontStatus):
            CardStudyPage_Middle_Card_Front(headword: currentCard.currentCard?.targetWordDataModel.headWord ?? "Apple", 
                                            frontStatus: frontStatus)
                .movable(vm)
        case .back(.detail):
            CardStudyPage_Middle_Card_Detail()
        case .back(.quiz):
            CardStudyPage_Middle_Card_Quiz()
        }
    }
}

#Preview {
    MainPage()
}
