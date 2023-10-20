//
//  CardData.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import Foundation

struct CardData {
    var originalWord: String // 영어 단어
    var translatedWord: String // 한글 뜻
    var englishDefinition: String // 영어 뜻
    var exampleSentence: String // 영어 예문
    var learningScore: Int // 학습 정도 0...100
    var consecutiveCorrectStreak: Int // 연속으로 맞춘 횟수 0...4
    
}
