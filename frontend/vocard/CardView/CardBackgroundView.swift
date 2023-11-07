//
//  CardBackgroundView.swift
//  vocard
//
//  Created by windowcow on 11/7/23.
//

import SwiftUI

enum CardFaceDirection {
    case faceUp, faceDown
}

struct CardBackgroundView: View {
    let cardFaceDirection: CardFaceDirection
    let backgroundColor: Color
    
    var body: some View {
        switch cardFaceDirection {
        case .faceUp:
            CardFrontShape()
                .fill(backgroundColor)
                .frame(width: 338, height: 553)
        case .faceDown:
            CardBackShape()
                .fill(backgroundColor)
                .frame(width: 338, height: 553)
        }
            

    }
}

//#Preview {
//    CardBackgroundView()
//}
