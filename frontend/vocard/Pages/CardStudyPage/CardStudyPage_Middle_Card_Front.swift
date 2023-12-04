//
//  MainPage_CardStudyPage_Middle_Card_Front.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/4/23.
//

import SwiftUI


struct CardStudyPage_Middle_Card_Front: View {
    /// switch view
    @Environment(CardStudyPageViewModel.self) var vm
    var headword: String

    var body: some View {
        ZStack {
            switch vm.cardViewStatus {
            case .middle:
                CardBackgroundView(backgroundColor: .mint)
                    .overlay {
                        Text(headword)
                    }
            case .left:
                CardBackgroundView(backgroundColor: .gray)
                    .overlay {
                        Text("DETAIL")
                    }
                
            case .right:
                CardBackgroundView(backgroundColor: .gray)
                    .overlay {
                        Text("QUIZ")
                    }
            }
        }
        
    }
}

struct CardBackgroundView: View {
    var backgroundColor: Color
    
    var body: some View {
        ZStack {
            backgroundColor
        }
        .aspectRatio(0.66, contentMode: .fit)
        .clipShape(.rect(cornerRadius: 15))
    }
}


//#Preview {
//    MainPage_CardStudyPage_Middle_Card_Front()
//}
