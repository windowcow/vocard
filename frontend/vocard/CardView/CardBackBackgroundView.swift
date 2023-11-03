//
//  CardBackBackgroundView.swift
//  vocard
//
//  Created by windowcow on 11/3/23.
//

import SwiftUI

struct CardBackBackgroundView: View {
    let backgroundColor: Color

    var body: some View {
        CardBackShape()
            .fill(backgroundColor)
            .frame(width: 338, height: 553)

    }
}

#Preview {
    CardBackBackgroundView(backgroundColor: .cardBack)
}
