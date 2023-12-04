//
//  QuizDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import SwiftData
import Foundation

@Model final class QuizDataModel {
    var id: UUID
    
    var question: String
    var choices: [String] // choice 4개
    var answer: Int /// 1...4
    
    init(id: UUID = UUID(), question: String, choices: [String], answer: Int) {
        self.id = id
        self.question = question
        self.choices = choices
        self.answer = answer
    }
}

extension QuizDataModel {
    static var samples: [QuizDataModel] {
        [
            QuizDataModel(question: "Conversation", choices: ["a good time to go", "A nice way to leave", "talk with", "to go"], answer: 3),
            QuizDataModel(question: "Swift에서 상수를 선언하는 키워드는?", choices: ["var", "let", "const", "static"], answer: 2),
            QuizDataModel(question: "태양계에서 가장 큰 행성은?", choices: ["지구", "목성", "화성", "토성"], answer: 2),
            QuizDataModel(question: "해리 포터 시리즈의 저자는?", choices: ["J.K. 롤링", "스티븐 킹", "조지 R.R. 마틴", "톨킨"], answer: 1),
            QuizDataModel(question: "물의 화학식은?", choices: ["CO2", "H2O", "O2", "C2H6"], answer: 2),
            QuizDataModel(question: "피아노에서 흰 건반의 수는 몇 개인가요?", choices: ["52개", "54개", "56개", "58개"], answer: 1),
            QuizDataModel(question: "커피 원두의 원산지는 어디인가요?", choices: ["브라질", "에티오피아", "콜롬비아", "베트남"], answer: 2),
            QuizDataModel(question: "세계에서 가장 긴 강은?", choices: ["나일 강", "아마존 강", "양쯔 강", "미시시피 강"], answer: 1),
            QuizDataModel(question: "피카소는 어느 나라 화가인가요?", choices: ["스페인", "이탈리아", "프랑스", "독일"], answer: 1),
            QuizDataModel(question: "다음 중 프로그래밍 언어가 아닌 것은?", choices: ["Python", "Ruby", "Eclipse", "Java"], answer: 3)
        ]
    }
}
