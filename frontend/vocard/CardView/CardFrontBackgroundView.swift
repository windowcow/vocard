//
//  CardBackgroundView.swift
//  vocard
//
//  Created by windowcow on 11/3/23.
//

import SwiftUI

struct CardFrontBackgroundView: View {
    let backgroundColor: Color
    
    var body: some View {
        CardFrontShape()
            .fill(backgroundColor)
            .frame(width: 338, height: 553)
        
    }
}

#Preview {
    CardFrontBackgroundView(backgroundColor: .cardFront)
}
