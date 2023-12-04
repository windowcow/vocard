//
//  ReviewResultDataModel.swift
//  vocard
//
//  Created by windowcow on 12/1/23.
//

import Foundation
import SwiftData

enum ReviewResultType: Codable, CaseIterable {
    case success, fail
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
