//
//  DeckDataModel.swift
//  vocard
//
//  Created by windowcow on 11/16/23.
//

import SwiftData

@Model
class DeckDataModel {
    var allCards = [CardDataModel]()
    var sortedDealtCards = [CardDataModel]()
    var sortedUndealtCards = [CardDataModel]()
    var userSettingDataModel: UserSettingsDataModel

    init(userSettingDataModel: UserSettingsDataModel) {

        self.allCards = []
        self.sortedDealtCards = []
        self.sortedUndealtCards = []
        self.userSettingDataModel = userSettingDataModel
    }
    
    func sortDecks() {
        sortedDealtCards = allCards.filter({ card in
            card.recentViewDate != nil
        })
        .sorted(by: { card1, card2 in
            card1.weight > card2.weight
        })
        sortedUndealtCards = allCards.filter({ card in
            card.recentViewDate == nil
        })
        .sorted(by: { card1, card2 in
            card1.weight > card2.weight
        })
    }
    
    func drawACard() -> CardDataModel {
        if sortedDealtCards.isEmpty {
            return sortedUndealtCards[0]
        } else if sortedUndealtCards.isEmpty {
            return sortedDealtCards[0]
        } else {
            return [sortedUndealtCards[0], sortedUndealtCards[0]].randomElement()!
        }
    }
}

protocol Drawable {
    var weight: Double { get set }
}
