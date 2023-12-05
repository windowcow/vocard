//
//  WordDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import SwiftData
import Foundation

@Model final class WordData {
    var pos: String
    var headWord: String
    var senseNum: Int
    
    @Relationship(inverse: \MeaningData.wordData) var wordMeaningDataModels: [MeaningData]
    @Relationship(inverse: \QuizData.wordData) var quizzes: [QuizData]
    
    
    
    init(pos: String, headWord: String, sense_num: Int, wordMeaningDataModels: [MeaningData] = [], quizzes: [QuizData] = []) {
        self.pos = pos
        self.headWord = headWord
        self.senseNum = sense_num
        self.wordMeaningDataModels = wordMeaningDataModels
        self.quizzes = quizzes
    }
}

extension WordData {
    static var samples: [WordData] {
        [
            WordData(pos: "verb", headWord: "conversation", sense_num: 1),
            WordData(pos: "noun", headWord: "innovation", sense_num: 2),
            WordData(pos: "adjective", headWord: "beautiful", sense_num: 1),
            WordData(pos: "adverb", headWord: "quickly", sense_num: 1),
            WordData(pos: "verb", headWord: "create", sense_num: 3),
            WordData(pos: "noun", headWord: "harmony", sense_num: 2),
            WordData(pos: "adjective", headWord: "efficient", sense_num: 1),
            WordData(pos: "adverb", headWord: "silently", sense_num: 2),
            WordData(pos: "verb", headWord: "explore", sense_num: 1),
            WordData(pos: "noun", headWord: "perspective", sense_num: 3),
            WordData(pos: "noun", headWord: "happiness", sense_num: 1),
            WordData(pos: "verb", headWord: "explore", sense_num: 2),
            WordData(pos: "adjective", headWord: "mysterious", sense_num: 1),
            WordData(pos: "adverb", headWord: "softly", sense_num: 1),
            WordData(pos: "verb", headWord: "imagine", sense_num: 2),
            WordData(pos: "noun", headWord: "freedom", sense_num: 1),
            WordData(pos: "adjective", headWord: "vibrant", sense_num: 1),
            WordData(pos: "adverb", headWord: "eagerly", sense_num: 1),
            WordData(pos: "verb", headWord: "transform", sense_num: 3),
            WordData(pos: "noun", headWord: "wisdom", sense_num: 2)
        ]
    }
}


