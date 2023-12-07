//
//  MainPage_CardStudyPage_Middle_Card_Front.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/4/23.
//

import SwiftUI


struct CardStudyPage_Middle_Card_Front: View {
    /// switch view
    var headword: String
    var frontStatus: CardViewStatus.FrontStatus

    var body: some View {
        ZStack {
            switch frontStatus {
            case .middle:
                CardBackgroundView(backgroundColor: .cardFrontYellow)
                    .overlay {
                        Text(headword)
                            .rotation3DEffect(
                                .degrees(0),
                                                      
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                            
                    }
            case .left:
                CardBackgroundView(backgroundColor: .gray)
                    .overlay {
                        Text("DETAIL")
                            .rotation3DEffect(
                                .degrees(180),
                                                      
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                        
                    }
                
            case .right:
                CardBackgroundView(backgroundColor: .gray)
                    .overlay {
                        Text("QUIZ")
                            .rotation3DEffect(
                                .degrees(180),
                                                      
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
            }
        }
        .font(.largeTitle)
        .bold()
        
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
