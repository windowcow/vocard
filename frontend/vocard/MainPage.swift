//
//  MainPage.swift
//  vocard
//
//  Created by windowcow on 11/30/23.
//

import SwiftUI
import SwiftData
import Charts

struct MainPage: View {
    var body: some View {
        VStack {
            MainPage_Top()
                .frame(maxHeight: 100)
            Spacer()
            MainPage_Middle_StarCount()
            Spacer()
            MainPage_Middle_NextWord()
        }
    }
}

struct MainPage_Top: View {
    var body: some View {
        HStack {
            Image(.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            Button("My Page") {
                
            }
            Button("Alarm") {
                
            }
        }
        
    }
}

struct DateStarCount: Identifiable {
    var id: Date {
        date
    }
    
    var date: Date
    var starCount: Int
}


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
                AxisMarks(format: .dateTime.weekday(.abbreviated).locale(Locale(identifier: "ko_KR")), position: .bottom, values: [0, 1, 2, 3, 4, 5, 6, 7].map{Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date.now.addingTimeInterval(-TimeInterval.Day * $0))!})
//                AxisT
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

struct MainPage_Middle_StarCount_Chart: View {
    var body: some View {
        EmptyView()
    }
}

struct MainPage_Middle_NextWord: View {
    var body: some View {
        VStack{
            
        }
    }
}

@Model final class ReviewResult {
    var targetWord: WordDataModel
    var reviewDate: Date
    var result: ReviewResultType
    
    init(targetWord: WordDataModel, reviewDate: Date, result: ReviewResultType) {
        self.targetWord = targetWord
        self.reviewDate = reviewDate
        self.result = result
    }
    
    static var samples: [ReviewResult] {
        var res: [ReviewResult] = []
        for word in WordDataModel.samples {
            res.append(ReviewResult.init(targetWord: word, reviewDate: .init(timeIntervalSinceNow: [0, -1, -2, -3, -4, -5, -6].randomElement()! * TimeInterval.Day), result: ReviewResultType.allCases.randomElement()!))
        }
        return res
    }
}

enum ReviewResultType: Codable, CaseIterable {
    case success, fail
}

#Preview {
    MainPage()
        .background(.black)
        .modelContainer(sampleContainer)
}
