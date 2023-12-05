//
//  CardStudyPage_Top.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/3/23.
//

import Foundation
import SwiftUI
import SwiftData


struct CardStudyPage_Top: View {
    @Environment(\.modelContext) private var modelContext
    @Query var reviewResultDataModels: [ReviewData]
//    @State private var reviewToday: [ReviewResultDataModel] = []
    @State private var todaysStars: Int = 0
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .center) {
                Text("TODAY")
                    .font(.title)
                    .bold()
                Text(Image(systemName: "star.fill"))
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .baselineOffset(3)
                    .foregroundStyle(.yellow)

                +
                Text("\(todaysStars) ")
                    .fontWeight(.heavy)
                    .font(.system(size: 48))
            }
            .foregroundStyle(.white)
            
            Spacer()
            Button("MENU") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .tint(.white)
            .foregroundStyle(.black)
        }
        // VIEW END
        .task {
            todaysStars = reviewResultDataModels.filter { r in
                r.reviewDate.defaultToMidnight == Date.now.defaultToMidnight
            }.reduce(0){$0 + $1.result.revenue}
        }
    }
} 

#Preview {
    MainPage()
        .modelContainer(sharedModelContainer)
}
