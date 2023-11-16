//
//  QuizDataModel.swift
//  vocard
//
//  Created by windowcow on 11/14/23.
//

import SwiftData
import Foundation

@Model class QuizDataModel {
    var question: String
    
    var choice1: String
    var choice2: String
    var choice3: String
    var choice4: String
    
    var answer: Int
    
    init(question: String, choice1: String, choice2: String, choice3: String, choice4: String, answer: Int) {
        self.question = question
        self.choice1 = choice1
        self.choice2 = choice2
        self.choice3 = choice3
        self.choice4 = choice4
        self.answer = answer
    }

}

extension QuizDataModel {
    static var quiz: QuizDataModel {
        QuizDataModel(
            question: "Which of the following is not typically associated with a meaningful conversation?",
            choice1: "Respect for differing viewpoints.",
            choice2: "Active listening.",
            choice3: "Frequent interruptions.",
            choice4: "Thoughtful responses.",
            answer: 3
        )
    }
}
