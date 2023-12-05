//
//  CardStudyPageViewModel.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import Foundation

@Observable  class CardStudyPageViewModel {
    var cardViewStatus: CardViewStatus = .front(.middle)
    var selectedChoice: Int?
    
    func refresh() {
        cardViewStatus = .front(.middle)
        selectedChoice = nil
    }
}
