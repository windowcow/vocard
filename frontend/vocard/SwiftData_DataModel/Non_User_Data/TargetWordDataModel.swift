//
//  WordDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import SwiftData
import Foundation

@Model final class TargetWordDataModel {
    var id: UUID
    var pos: String
    var headWord: String
    var sense_num: Int
    var wordMeaningDataModels: [WordMeaningDataModel]
    var quizzes: [QuizDataModel]
    
    init(id: UUID = UUID(), pos: String, headWord: String, sense_num: Int, wordMeaningDataModels: [WordMeaningDataModel] = [], quizzes: [QuizDataModel] = []) {
        self.id = id
        self.pos = pos
        self.headWord = headWord
        self.sense_num = sense_num
        self.wordMeaningDataModels = wordMeaningDataModels
        self.quizzes = quizzes
    }
}

extension TargetWordDataModel {
    static var samples: [TargetWordDataModel] {
        [
            TargetWordDataModel(pos: "verb", headWord: "conversation", sense_num: 1),
            TargetWordDataModel(pos: "noun", headWord: "innovation", sense_num: 2),
            TargetWordDataModel(pos: "adjective", headWord: "beautiful", sense_num: 1),
            TargetWordDataModel(pos: "adverb", headWord: "quickly", sense_num: 1),
            TargetWordDataModel(pos: "verb", headWord: "create", sense_num: 3),
            TargetWordDataModel(pos: "noun", headWord: "harmony", sense_num: 2),
            TargetWordDataModel(pos: "adjective", headWord: "efficient", sense_num: 1),
            TargetWordDataModel(pos: "adverb", headWord: "silently", sense_num: 2),
            TargetWordDataModel(pos: "verb", headWord: "explore", sense_num: 1),
            TargetWordDataModel(pos: "noun", headWord: "perspective", sense_num: 3),
            TargetWordDataModel(pos: "noun", headWord: "happiness", sense_num: 1),
            TargetWordDataModel(pos: "verb", headWord: "explore", sense_num: 2),
            TargetWordDataModel(pos: "adjective", headWord: "mysterious", sense_num: 1),
            TargetWordDataModel(pos: "adverb", headWord: "softly", sense_num: 1),
            TargetWordDataModel(pos: "verb", headWord: "imagine", sense_num: 2),
            TargetWordDataModel(pos: "noun", headWord: "freedom", sense_num: 1),
            TargetWordDataModel(pos: "adjective", headWord: "vibrant", sense_num: 1),
            TargetWordDataModel(pos: "adverb", headWord: "eagerly", sense_num: 1),
            TargetWordDataModel(pos: "verb", headWord: "transform", sense_num: 3),
            TargetWordDataModel(pos: "noun", headWord: "wisdom", sense_num: 2)
        ]
    }
}


