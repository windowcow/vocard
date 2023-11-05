//
//  CardData.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftData
import Foundation

@Model class Quiz {
    let question: String
    
    let choice1: String
    let choice2: String
    let choice3: String
    let choice4: String
    let answer: Int
    
    init(question: String, choice1: String, choice2: String, choice3: String, choice4: String, answer: Int) {
        self.question = question
        self.choice1 = choice1
        self.choice2 = choice2
        self.choice3 = choice3
        self.choice4 = choice4
        self.answer = answer
    }
    
    static let example = Quiz(
        question: "Which of the following is not typically associated with a meaningful conversation?",
        choice1: "Respect for differing viewpoints.",
        choice2: "Active listening.",
        choice3: "Frequent interruptions.",
        choice4: "Thoughtful responses.",
        answer: 3
    )
}


@Model class CardData {
    var originalWord: String // 영어 단어
    var koreanDefinition: String // 한글 뜻 (이 경우에는 사진에 나타나지 않으므로 옵셔널로 표시)
    var englishDefinition: String // 영어 뜻
    var exampleSentence: String // 영어 예문
    var learningScore: Int // 학습 정도 0...100
    var consecutiveCorrectStreak: Int // 연속으로 맞춘 횟수 0...4
    var recentViewDate: Date
    var quizes: [Quiz]
    
    init(originalWord: String, koreanDefinition: String, englishDefinition: String, exampleSentence: String, learningScore: Int, consecutiveCorrectStreak: Int, recentViewDate: Date, quizes: [Quiz]) {
        self.originalWord = originalWord
        self.koreanDefinition = koreanDefinition
        self.englishDefinition = englishDefinition
        self.exampleSentence = exampleSentence
        self.learningScore = learningScore
        self.consecutiveCorrectStreak = consecutiveCorrectStreak
        self.recentViewDate = recentViewDate
        self.quizes = quizes
    }
    
    
    static let example1 = CardData(
        originalWord: "conversation",
        koreanDefinition: "대화",
        englishDefinition: "oral exchange of sentiments, observations, opinions, or ideas",
        exampleSentence: "I like having conversations with my friend.",
        learningScore: 20,
        consecutiveCorrectStreak: 1,
        recentViewDate: Date.now,
        quizes: [Quiz.example]
    )
    
    static let example2 = CardData(
        originalWord: "acknowledge",
        koreanDefinition: "인정하다",
        englishDefinition: "accept or admit the existence or truth of",
        exampleSentence: "She acknowledged that she was at fault.",
        learningScore: 15,
        consecutiveCorrectStreak: 2,
        recentViewDate: Date.now,
        quizes: [Quiz.example]
    )

    static let example3 = CardData(
        originalWord: "inspiration",
        koreanDefinition: "영감",
        englishDefinition: "the process of being mentally stimulated to do or feel something",
        exampleSentence: "His talk was an inspiration to me.",
        learningScore: 30,
        consecutiveCorrectStreak: 5,
        recentViewDate: Date.now,
        quizes: [Quiz.example]
    )

    static let example4 = CardData(
        originalWord: "meticulous",
        koreanDefinition: "세심한",
        englishDefinition: "showing great attention to detail; very careful and precise",
        exampleSentence: "He is very meticulous in his work.",
        learningScore: 25,
        consecutiveCorrectStreak: 3,
        recentViewDate: Date.now,
        quizes: [Quiz.example]
    )
}
