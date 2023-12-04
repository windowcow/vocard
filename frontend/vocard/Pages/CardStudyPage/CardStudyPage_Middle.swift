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

struct CardStudyPage_Middle_Card: View {
    @Environment(CardDataModel.self) var currentCard: CardDataModel?
    @State private var vm: CardStudyPageViewModel = CardStudyPageViewModel()
    @Binding var cardViewStatus: CardViewStatus
    
    var body: some View {
        switch cardViewStatus {
        case .front:
            CardStudyPage_Middle_Card_Front(headword: currentCard?.targetWordDataModel.headWord ?? "Apple")
                .environment(vm)
                .movable(vm, $cardViewStatus)
        case .detail:
            CardStudyPage_Middle_Card_Detail()
        case .quiz:
            CardStudyPage_Middle_Card_Quiz()
        }
    }
}

struct CardStudyPage_Middle_Card_Detail: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

struct CardStudyPage_Middle_Card_Quiz: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
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
