//
//  ReviewResultDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftData

@Model final class ReviewResultDataModel {
    var reviewDate: Date
    var result: ReviewResult_ResultAndRevenue
    @Relationship(inverse: \CardDataModel.reviewResults) var cardDataModel: CardDataModel?
    
    init(reviewDate: Date = Date.now, result: ReviewResult_ResultAndRevenue) {
        self.reviewDate = reviewDate
        self.result = result
    }
}



enum ReviewResult_ResultAndRevenue: Codable, Hashable {
    case success(Int), fail(Int)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .success(let s):
            hasher.combine(0)
            hasher.combine(s)
        case .fail(let f):
            hasher.combine(1)
            hasher.combine(f)
        }
    }
    
    var revenue: Int {
        switch self {
        case .success(let s):
            return s
        case .fail(let f):
            return f
        }
    }
}


