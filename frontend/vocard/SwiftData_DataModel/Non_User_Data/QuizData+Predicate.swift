//
//  QuizData+Predicate.swift
//  vocard
//
//  Created by windowcow on 12/6/23.
//
import Foundation
import SwiftData

extension QuizData: Identifiable { }
extension QuizData {
    static func predicate(
        headword: String,
        senNum: Int
    ) -> Predicate<QuizData> {
        return #Predicate<QuizData> { quiz in
            if let wordData = quiz.wordData {
                return wordData.headword == headword && wordData.senseNum == senNum
            } else {
                return true
            }
        }
    }
}
