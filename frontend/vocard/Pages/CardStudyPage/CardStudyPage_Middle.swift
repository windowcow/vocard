//
//  MainPage_CardStudyPage_Middle.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftUI

struct CardStudyPage_Middle: View {
    @Environment(CardStudyPageViewModel.self) var vm: CardStudyPageViewModel
    
    var body: some View {
        ZStack {
            Color.clear
            CardStudyPage_Middle_Card()
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
    enum FrontStatus {
        case middle, left, right
    }
    
    enum BackStatus {
        case detail, quiz
    }
    
    case front(FrontStatus), back(BackStatus)
}





#Preview {
    MainPage()
        .modelContainer(sharedModelContainer)
}
