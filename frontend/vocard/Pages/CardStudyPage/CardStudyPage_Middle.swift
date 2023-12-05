//
//  MainPage_CardStudyPage_Middle.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftUI

struct CardStudyPage_Middle: View {
    @Environment(CardDataModel.self) var currentCard: CardDataModel?
    @Binding var cardViewStatus: CardViewStatus
    
    var body: some View {
        ZStack {
            Color.clear
            CardStudyPage_Middle_Card( cardViewStatus: $cardViewStatus)
            
        }
    }
}





enum CardMovementLocation {
    case left, center, right
    
    var range: Range<CGFloat> {
        switch self {
        case .left:
            -CGFloat.infinity ..< -90
        case .center:
            -90 ..< 90
        case .right:
            90 ..< CGFloat.infinity
        }
    }
}


enum CardViewStatus: Equatable {
    case front, detail, quiz
}

enum CardViewFrontStatus: Equatable {
    case middle, left, right
}

@Observable  class CardStudyPageViewModel {
    var cardViewStatus: CardViewFrontStatus = .middle
}



#Preview {
    MainPage()
        .modelContainer(sharedModelContainer)
}
