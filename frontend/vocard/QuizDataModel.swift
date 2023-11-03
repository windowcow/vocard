//
//  QuizDataModel.swift
//  vocard
//
//  Created by windowcow on 11/3/23.
//

import Foundation

struct Quiz {
    let question: String
    
    let choice1: String
    let choice2: String
    let choice3: String
    let choice4: String
    let answer: Int
    
    static let example = Quiz(
        question: "Which of the following is not typically associated with a meaningful conversation?",
        choice1: "Respect for differing viewpoints.",
        choice2: "Active listening.",
        choice3: "Frequent interruptions.",
        choice4: "Thoughtful responses.",
        answer: 3
    )
}
