//
//  MainPage.swift
//  vocard
//
//  Created by windowcow on 11/30/23.
//

import SwiftUI
import SwiftData

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


struct MainPage_Middle_StarCount: View {
    var body: some View {
        HStack {
            
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
