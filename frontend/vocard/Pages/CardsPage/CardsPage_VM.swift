//
//  CardsPage_VM.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import Foundation

@Observable class CardsPage_VM {
    var columnNum: Int = 3
    var selectedDate: Date = Date.now
    var seenFilterType: SeenFilterType = .all
    var filterBy: FilterType = .none(.ascending)
    
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
