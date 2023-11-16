//
//  UserSettingsDataModel.swift
//  vocard
//
//  Created by windowcow on 11/16/23.
//

import SwiftData

@Model
class UserSettingsDataModel {
    var undealtCardAppearProbability: Double = 50
    
    init(undealtCardAppearProbability: Double) {
        self.undealtCardAppearProbability = undealtCardAppearProbability
    }
}
