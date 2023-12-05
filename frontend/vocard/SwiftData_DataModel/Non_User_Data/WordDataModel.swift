//
//  WordDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import SwiftData
import Foundation

@Model final class WordDataModel {
    var id: UUID
    var pos: String
    var headWord: String
    var sense_num: Int
    var wordMeaningDataModels: [MeaningDataModel]
    var quizzes: [QuizDataModel]
    
    
    
    init(id: UUID = UUID(), pos: String, headWord: String, sense_num: Int, wordMeaningDataModels: [MeaningDataModel] = [], quizzes: [QuizDataModel] = []) {
        self.id = id
        self.pos = pos
        self.headWord = headWord
        self.sense_num = sense_num
        self.wordMeaningDataModels = wordMeaningDataModels
        self.quizzes = quizzes
    }
}

extension WordDataModel {
    static var samples: [WordDataModel] {
        [
            WordDataModel(pos: "verb", headWord: "conversation", sense_num: 1),
            WordDataModel(pos: "noun", headWord: "innovation", sense_num: 2),
            WordDataModel(pos: "adjective", headWord: "beautiful", sense_num: 1),
            WordDataModel(pos: "adverb", headWord: "quickly", sense_num: 1),
            WordDataModel(pos: "verb", headWord: "create", sense_num: 3),
            WordDataModel(pos: "noun", headWord: "harmony", sense_num: 2),
            WordDataModel(pos: "adjective", headWord: "efficient", sense_num: 1),
            WordDataModel(pos: "adverb", headWord: "silently", sense_num: 2),
            WordDataModel(pos: "verb", headWord: "explore", sense_num: 1),
            WordDataModel(pos: "noun", headWord: "perspective", sense_num: 3),
            WordDataModel(pos: "noun", headWord: "happiness", sense_num: 1),
            WordDataModel(pos: "verb", headWord: "explore", sense_num: 2),
            WordDataModel(pos: "adjective", headWord: "mysterious", sense_num: 1),
            WordDataModel(pos: "adverb", headWord: "softly", sense_num: 1),
            WordDataModel(pos: "verb", headWord: "imagine", sense_num: 2),
            WordDataModel(pos: "noun", headWord: "freedom", sense_num: 1),
            WordDataModel(pos: "adjective", headWord: "vibrant", sense_num: 1),
            WordDataModel(pos: "adverb", headWord: "eagerly", sense_num: 1),
            WordDataModel(pos: "verb", headWord: "transform", sense_num: 3),
            WordDataModel(pos: "noun", headWord: "wisdom", sense_num: 2)
        ]
    }
}


