//
//  CardDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftData

@Model class CardDataModel {
    @Relationship var targetWordDataModel: WordData
    @Relationship(inverse: \ReviewResultDataModel.cardDataModel) var reviewResults: [ReviewResultDataModel] /// 여거는 항상 합이 0...5로 유지 되어야 하기 때문에 reviewsuccess, reviewfail로만 관리된다.
    
    init(targetWordDataModel: WordData = WordData(pos: "", headWord: "", sense_num: 1),
         reviewResults: [ReviewResultDataModel] = []) {
        self.targetWordDataModel = targetWordDataModel
        self.reviewResults = reviewResults
    }
    
    
}



/// About Review Weight
extension CardDataModel {
    /// weight는 무조건 현재의 시간을 기준으로 계산될 수 밖에 없다.
    /// 외부 공개된 프로퍼티
    enum CurrentStarCount: Int, Codable {
        case zero = 0, one, two, three, four, max // max는 5
    }
    /// private
    
    
    var isUnseen: Bool {
        reviewResults.isEmpty
    }
    
    var lastReviewDate: Date? {
        /// nil인 경우는 unseen card인 경우와 완전히 같다.
        return reviewResults.last?.reviewDate
    }
    
    var timeSinceLastReview: TimeInterval? {
        /// 6일 전이면 -6.day가 아니고 6.day반환
        guard let lastReviewDate = lastReviewDate else {
            return nil
        }
        return -lastReviewDate.timeIntervalSinceNow
    }
    
    var weight: Double? {
        guard let timeSinceLastReview = timeSinceLastReview else {
            return nil
        }
        
        switch currentStarCount {
        case nil:
            return nil
        case .max:
            return nil
        case .zero:
            return timeSinceLastReview / 1.hour
        case .one:
            return timeSinceLastReview / 3.hour
        case .two:
            return timeSinceLastReview / 3.hour
        case .three:
            return timeSinceLastReview / 3.hour
        case .four:
            return timeSinceLastReview / 3.hour
        }
    }
    
    var currentStarCount: CurrentStarCount? {
        /// nil인 경우는 처음 본 카드인 경우와 완전히 같다.
        if isUnseen {
            return nil
        }
        
        var res = 0
        
        for reviewResult in reviewResults {
            switch reviewResult.result {
            case .success(let s):
                res += s
            case .fail(let f):
                res += f
            }
        }
        
        return CurrentStarCount(rawValue: res)
    }
    
    
    
    func reviewSuccessed() throws {
        guard let context = self.modelContext else {
            fatalError("CardDataModel_reviewSuccessed")
        }
        
        let newReviewResultDataModel = ReviewResultDataModel(result: ReviewResult_ResultAndRevenue.success(1))
        context.insert(newReviewResultDataModel)
        reviewResults.append(newReviewResultDataModel)
    }
    
    func reviewFailed() throws {
        guard let context = self.modelContext else {
            fatalError("CardDataModel_reviewFailed")
        }
        
        var revenue = 0
        
        switch currentStarCount {
        case nil:
            revenue = 0
        case .zero:
            revenue = 0
        default:
            revenue = -1
        
        }
        
        let newReviewResultDataModel = ReviewResultDataModel(result: .fail(revenue))
        context.insert(newReviewResultDataModel)
        reviewResults.append(newReviewResultDataModel)

    }
}
