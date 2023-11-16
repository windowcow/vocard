//
//  DeckDataModel.swift
//  vocard
//
//  Created by windowcow on 11/16/23.
//

import SwiftData

@Model
class DeckDataModel {
    var sortedDealtCards = [CardDataModel]()
    var sortedUndealtCards = [CardDataModel]()
    var userSettingDataModel: UserSettingsDataModel

    init(userSettingDataModel: UserSettingsDataModel) {
        self.sortedDealtCards = []
        self.sortedUndealtCards = []
        self.userSettingDataModel = userSettingDataModel
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
