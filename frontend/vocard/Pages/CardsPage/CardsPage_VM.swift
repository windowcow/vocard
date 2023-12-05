//
//  CardsPage_VM.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import Foundation

@Observable class CardsPage_VM {
    var allCards: [CardDataModel] = []
    var columnNum: Int = 3
    var selectedDate: Date = Date.now
    var seenFilterType: SeenFilterType = .all
    var filterBy: FilterType = .none(.ascending)
    
    init(allCards: [CardDataModel] = []) {
        self.allCards = allCards
    }
    
    var cards: [CardDataModel] {
        allCards.filter { card in
            card.reviewResults.contains { reviewDataModel in
                selectedDate.ymd == reviewDataModel.reviewDate.ymd
            }
            
        }
        .filter { card in
            switch seenFilterType {
            case .all:
                return true
            case .seen:
                return !card.isUnseen
            case .unseen:
                return card.isUnseen
            }
        }
        .sorted { card1, card2 in
            switch filterBy {
            case .none:
                true
            case .alphabet:
                card1.targetWordDataModel.headWord < card2.targetWordDataModel.headWord
            case .stars(let sortOrder):
                card1.currentStarCount?.rawValue ?? 0 < card2.currentStarCount?.rawValue ?? 0
            }
        }
    }
    
    enum SeenFilterType {
        case all, seen, unseen
    }
    
    
    enum FilterType {
        enum SortOrder {
            case ascending, descending
        }
        case none(SortOrder), alphabet(SortOrder), stars(SortOrder)
    }
}
