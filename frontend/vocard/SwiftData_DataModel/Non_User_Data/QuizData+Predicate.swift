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
            return true
//            if let wordData = quiz.wordData {
//                return wordData.headWord == headword && wordData.senseNum == senNum
//            } else {
//                return true
//            }
        }
    }
}
