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
    static var quizs: [QuizDataModel] =
        [
            QuizDataModel(
                question: "Which of the following is not typically associated with a meaningful conversation?",
                choice1: "Respect for differing viewpoints.",
                choice2: "Active listening.",
                choice3: "Frequent interruptions.",
                choice4: "Thoughtful responses.",
                answer: 3 // 1...4
            ),
            QuizDataModel( question: "What is essential for effective team collaboration in a workplace?", choice1: "Individual competition.", choice2: "Clear communication.", choice3: "Avoiding feedback.", choice4: "Shared goals.", answer: 4),
            QuizDataModel( question: "Which activity is least likely to reduce stress?", choice1: "Deep breathing exercises.", choice2: "Regular physical exercise.", choice3: "Spending time in nature.", choice4: "Overworking without breaks.", answer: 4),

            QuizDataModel( question: "What is not a characteristic of healthy eating?", choice1: "Balanced nutrient intake.", choice2: "Regular consumption of fast food.", choice3: "Eating a variety of foods.", choice4: "Limiting processed sugar.", answer: 2 ),

            QuizDataModel( question: "Which is not a common practice in effective time management?", choice1: "Setting clear priorities.", choice2: "Procrastinating important tasks.", choice3: "Breaking tasks into smaller steps.", choice4: "Avoiding unnecessary meetings.", answer: 2 ),

            QuizDataModel( question: "In environmental conservation, which action is least effective?", choice1: "Recycling and reusing materials.", choice2: "Conserving water and energy.", choice3: "Planting trees and supporting biodiversity.", choice4: "Ignoring pollution regulations.", answer: 4 )
        ]
    
}
