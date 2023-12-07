//
//  CardGPTPage.swift
//  vocard
//
//  Created by windowcow on 12/7/23.
//

import SwiftUI

struct CardGPTPage: View {
    var headword: String
    var meaning: MeaningData
    
    var body: some View {
        ZStack {
            Color.clear
            VStack(alignment: .leading) {
                Text(headword)
                    .font(.largeTitle)
                    .bold()
                (Text("\(meaning.meaningNum)") + Text(". ") + Text(meaning.meaning))
                    .foregroundStyle(.black)
            }
        }
    }
}
//
//#Preview {
//    CardGPTPage()
//}
