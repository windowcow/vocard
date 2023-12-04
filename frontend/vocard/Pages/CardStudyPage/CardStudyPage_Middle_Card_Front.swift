//
//  MainPage_CardStudyPage_Middle_Card_Front.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/4/23.
//

import SwiftUI

struct CardBackgroundView: View {
    var backgroundColor: Color
    
    var body: some View {
        ZStack {
            backgroundColor
        }
        .aspectRatio(0.66, contentMode: .fit)
    }
}

struct CardStudyPage_Middle_Card_Front: View {
    /// switch view
    @Binding var currentCardFrontViewState: CardViewStatus.CardFrontStatus
    var headword: String
    
    var body: some View {
        switch currentCardFrontViewState {
        case .middle:
            CardBackgroundView(backgroundColor: .mint)
                .overlay {
                    Text(headword)
                }
        case .left:
            CardBackgroundView(backgroundColor: .mint)
                .overlay {
                    Text(headword)
                }
            
        case .right:
            CardBackgroundView(backgroundColor: .mint)
                .overlay {
                    Text(headword)
                }
        }
    }
}

//#Preview {
//    MainPage_CardStudyPage_Middle_Card_Front()
//}
