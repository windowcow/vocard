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
        ZStack(alignment: .topLeading) {
            Color.clear
            VStack(alignment: .leading) {
                (
                Text(meaning.wordData?.headword ?? headword)
                    .font(.largeTitle)
                    .bold() +
                Text("\(meaning.wordData?.senseNum ?? 1)")
                    .baselineOffset(8)
                )
                Text(meaning.wordData?.pos ?? "verb")
                    .font(.caption)
                    .padding(.bottom)

                (Text("\(meaning.meaningNum)") + Text(". ") + Text(meaning.meaning))
                    .foregroundStyle(.black)
            }
        }
        .padding()
    }
}
//
//#Preview {
//    CardGPTPage()
//}
