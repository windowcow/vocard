//
//  CardData.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftData
import Foundation

@Model class CardDataModel {
    
    var originalWord: String // 영어 단어
    var koreanDefinition: String // 한글 뜻 (이 경우에는 사진에 나타나지 않으므로 옵셔널로 표시)
    var englishDefinition: String // 영어 뜻
    var exampleSentence: String // 영어 예문
    
    
    
    
    var quizes = [QuizDataModel]()
    
    
    
    var recentViewDate: Date?
    
    var consecutiveReviewSuccessStreak: ConsecutiveReviewSuccessStreak = ConsecutiveReviewSuccessStreak.zero
    
    var weight: Double {
        guard let recentViewDate = recentViewDate else {
            return 1
        }
        switch self.consecutiveReviewSuccessStreak {
        case .zero:
            return Date.now.timeIntervalSince(recentViewDate) / ConsecutiveReviewSuccessStreak.zero.requiredInterval
            
        case .one:
            return Date.now.timeIntervalSince(recentViewDate) / ConsecutiveReviewSuccessStreak.one.requiredInterval

        case .two:
            return Date.now.timeIntervalSince(recentViewDate) / ConsecutiveReviewSuccessStreak.two.requiredInterval

        case .three:
            return Date.now.timeIntervalSince(recentViewDate) / ConsecutiveReviewSuccessStreak.three.requiredInterval

        case .four:
            return Date.now.timeIntervalSince(recentViewDate) / ConsecutiveReviewSuccessStreak.four.requiredInterval

        case .five:
            return Date.now.timeIntervalSince(recentViewDate) / ConsecutiveReviewSuccessStreak.five.requiredInterval

        }
    }
    
    init(originalWord: String, koreanDefinition: String, englishDefinition: String, exampleSentence: String) {
        self.originalWord = originalWord
        self.koreanDefinition = koreanDefinition
        self.englishDefinition = englishDefinition
        self.exampleSentence = exampleSentence
    }
    
    
    enum ConsecutiveReviewSuccessStreak: Int, Codable {
        case zero = 0, one, two, three, four, five
        
        var requiredInterval: TimeInterval {
            switch self {
            case .zero:
                return .Minute * 30
            case .one:
                return .Hour * 6
            case .two:
                return .Hour * 24
            case .three:
                return .Day * 3
            case .four:
                return .Day * 7
            case .five:
                return .Day * 30
            }
            
        }
    }
}

extension CardDataModel {
    static var card: [CardDataModel] =
    [
        CardDataModel(
            originalWord: "conversation",
            koreanDefinition: "대화",
            englishDefinition: "oral exchange of sentiments, observations, opinions, or ideas",
            exampleSentence: "I like having conversations with my friend."
        ),
        CardDataModel(
            originalWord: "acknowledge",
            koreanDefinition: "인정하다",
            englishDefinition: "accept or admit the existence or truth of",
            exampleSentence: "She acknowledged that she was at fault."
        ),
        CardDataModel(
            originalWord: "inspiration",
            koreanDefinition: "영감",
            englishDefinition: "the process of being mentally stimulated to do or feel something",
            exampleSentence: "His talk was an inspiration to me."
        ),
        CardDataModel(
            originalWord: "meticulous",
            koreanDefinition: "세심한",
            englishDefinition: "showing great attention to detail; very careful and precise",
            exampleSentence: "He is very meticulous in his work."
        )
    ]
    
}

extension TimeInterval {
    static let Second: TimeInterval = 1
    static let Minute: TimeInterval = 60 * Second
    static var Hour: TimeInterval = 60 * Minute
    static let Day: TimeInterval = 24 * Hour
}
