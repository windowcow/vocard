//
//  MainPage_Middle.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import SwiftUI
import SwiftData


struct MainPage_Middle: View {
    @Query var reviewResults: [ReviewData]
    @State private var todaysStarRevenue: Int?
    
    var body: some View {
        HStack(alignment: .top) {
            MainPage_Middle_WeekChart()
            VStack {
                Text("WORD COUNT")
                Text("\(todaysStarRevenue ?? 0)")
                    .font(.system(size: 64))
            }
        }
        .task {
            var starRevenue = 0
            
            reviewResults.forEach { result in
                if result.reviewDate.defaultToMidnight == Date.now.defaultToMidnight {
                    starRevenue += result.result.revenue
                }
                
            }
            
            todaysStarRevenue = starRevenue
        }
    }
}
#Preview {
    MainPage()
}
