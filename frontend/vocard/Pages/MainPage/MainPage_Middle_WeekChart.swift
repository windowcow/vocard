//
//  ContentView.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 11/30/23.
//

import SwiftUI
import SwiftData
import Charts

struct MainPage_Middle_WeekChart: View {
    @Query var items: [ReviewData]
    @State var weekChartData: WeekChartData?

    var body: some View {
        Chart {
            if let weekChartData = weekChartData {
                ///
                ForEach(weekChartData.data.map{$0}, id: \.key) { data in
                    switch data.key.revenue {
                        
                    case .success:
                        BarMark(x: .value("", data.key.formattedWeekday), 
                                yStart: .value("", 0),
                                yEnd: .value("", data.value))
                        .foregroundStyle(.blue.gradient)
                        .cornerRadius(10)
                    case .fail:
                        BarMark(x: .value("", data.key.formattedWeekday), 
                                yStart: .value("", 0),
                                yEnd: .value("", data.value))
                        .foregroundStyle(.red.gradient)
                        .cornerRadius(10)

                    }
                }
                /// end if let
            }
        }
        .chartXScale(domain: Date.now.formattedPreviousWeekdays())
        .chartXAxis {
            AxisMarks( values: Date.now.formattedPreviousWeekdays() ) { value in
                if let weekday = value.as(String.self) {
                    AxisValueLabel {
                        Text(weekday)
                    }
                    .foregroundStyle(.white)
                }
                
                AxisGridLine()
                    .foregroundStyle(.white)
            }
        }
        .chartYAxis {
            AxisMarks {
                AxisValueLabel()
                    .foregroundStyle(.white)

                AxisGridLine()
                    .foregroundStyle(.white)

                AxisTick()
                    .foregroundStyle(.white)

            }
        }
        .padding()
        .background(.gray)
        .clipShape(.rect(cornerRadius: 10))
        .task {
            let res = items.filter { reviewResultDataModel in
                Date.now.getPastSevenYMDIncludingToday.contains { dateComponent in
                    dateComponent == reviewResultDataModel.reviewDate.ymd
                }
            }
            
            weekChartData = WeekChartData(res)
        }
    }
}




struct WeekChartData {
    // 최근 7일 간의 [ReviewResult]를 받아서 차트에서 쓸 수 있는 데이터로 담는다.
    // 이 구조체는 query를 받아서 복잡한 연산을 거친이후 보여주기만을 위함이다. 수정하는 경우에는 이렇게 하면 안된다.
    struct Key: Hashable {
        static func == (lhs: WeekChartData.Key, rhs: WeekChartData.Key) -> Bool {
            lhs.hashValue == rhs.hashValue
        }
        
        var formattedWeekday: String
        var revenue: ReviewResult_ResultAndRevenue
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(formattedWeekday)
            hasher.combine(revenue)
        }
    }
    
    var data: [Key:Int] = [:]
    
    init(_ items: [ReviewData]) {
        for item in items {
            switch item.result {
            case .success(let s):
                data[Key(formattedWeekday: item.reviewDate.formattedWeekday, revenue: item.result), default: 0] += s
            case .fail(let f):
                data[Key(formattedWeekday: item.reviewDate.formattedWeekday, revenue: item.result), default: 0] += f

            }
        }
    }
}








#Preview {
    MainPage_Middle_WeekChart()
//    MainPage()
        .background(.black)
        .foregroundStyle(.white)
        .modelContainer(sharedModelContainer)
}
