//
//  CardStudyPage_Top.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/3/23.
//

import Foundation
import SwiftUI
import SwiftData


//extension ReviewData {
//    static func predicate(card: CardData) -> Predicate<ReviewData> {
//           
//        return #Predicate<ReviewData> { review in
//            return Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: Date.now) ==
//            Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: review.reviewDate)
//
//        }
//    }
//}


struct CardStudyPage_Top: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Environment(CardStudyPageViewModel.self) var vm

    @Query var reviewResultDataModels: [ReviewData]
    @State private var todaysStars: Int = 0
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
        .onChange(of: vm.cardViewStatus, { oldValue, newValue in
//            print(111)
            todaysStars = reviewResultDataModels.filter { r in
                r.reviewDate.defaultToMidnight == Date.now.defaultToMidnight
            }.reduce(0){$0 + $1.result.revenue}
        })
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
