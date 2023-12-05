//
//  CardsPage_VM.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import Foundation

@Observable class CardsPage_VM {
    var columnNum: Int = 2
    var selectedDate: Date = Date.now
    var isSeenSelected: Bool = false
    var isUnseenSelected: Bool = false
}
