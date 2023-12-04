//
//  MainPage_Middle_StarCount.swift
//  vocard
//
//  Created by windowcow on 12/1/23.
//

import SwiftUI
import SwiftData
import Charts

struct MainPage_Middle_StarCount: View {
    @Query var reviewResult: [ReviewResult]
    
    @State private var data: [DateStarCount] = []
    
    var body: some View {
        HStack {
            Chart {
                ForEach(data) { data in
                    BarMark(x: .value("", data.date),
                            y: .value("", data.starCount))
                    
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom ,values: [0, 1, 2, 3, 4, 5, 6, 7].map{Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date.now.addingTimeInterval(-TimeInterval.Day * $0))!}) { value in
                    if let date = value.as(Date.self) {
                        AxisValueLabel {
                            Text(date, format: .dateTime.weekday(.abbreviated).locale(Locale(identifier: "ko_KR")))
                        }
                        AxisTick(centered: true)
                        AxisGridLine()

                    }
                    
                }
//                AxisMarks(format: .dateTime.weekday(.abbreviated).locale(Locale(identifier: "ko_KR")), position: .bottom, values: [0, 1, 2, 3, 4, 5, 6, 7].map{Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date.now.addingTimeInterval(-TimeInterval.Day * $0))!})
////                AxisTick(centered: true)
            }
            .padding()
            .frame(maxHeight: 300)
            

        }
        .task {
            
            var dict: [Date: Int] = [:]
            
            for result in reviewResult {
                switch result.result {
                case .success:
                    dict[Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: result.reviewDate)!, default: 0] += 1
                case .fail:
                    dict[Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: result.reviewDate)!, default: 0] -= 1
                }
                
            }
            data.removeAll()
            
            for (k, v) in dict {
                data.append(.init(date: k, starCount: v))
            }
        }
    }
}
#Preview {
    MainPage_Middle_StarCount()
}
