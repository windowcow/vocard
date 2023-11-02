//
//  CardData.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import Foundation

struct CardData {
    var originalWord: String // 영어 단어
    var translatedWord: String? // 한글 뜻 (이 경우에는 사진에 나타나지 않으므로 옵셔널로 표시)
    var englishDefinition: String // 영어 뜻
    var exampleSentence: String // 영어 예문
    var learningScore: Int // 학습 정도 0...100
    var consecutiveCorrectStreak: Int // 연속으로 맞춘 횟수 0...4
    
    static let example = CardData(
        originalWord: "conversation",
        translatedWord: nil,
        englishDefinition: "oral exchange of sentiments, observations, opinions, or ideas",
        exampleSentence: "I like having conversations with my friend.",
        learningScore: 20,
        consecutiveCorrectStreak: 1
    )
}
