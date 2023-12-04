//
//  WordMeaningDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftData

@Model final class WordMeaningDataModel {
    var id: UUID
    var meaningNum: Int
    var meaning: String
    var meaningInOtherLanguages: [String:String]
    var exampleSentences: [ExampleSentenceDataModel]
    
    init(id: UUID = UUID(), meaningNum: Int, meaning: String, meaningInOtherLanguages: [String : String] = [:], exampleSentences: [ExampleSentenceDataModel] = []) {
        self.id = id
        self.meaningNum = meaningNum
        self.meaning = meaning
        self.meaningInOtherLanguages = meaningInOtherLanguages
        self.exampleSentences = exampleSentences
    }
}

extension WordMeaningDataModel {
    static var samples: [WordMeaningDataModel] {
        [
            WordMeaningDataModel(meaningNum: 1, meaning: "To meet a friend"),
            WordMeaningDataModel(meaningNum: 2, meaning: "To engage in a hobby"),
            WordMeaningDataModel(meaningNum: 3, meaning: "To learn something new"),
            WordMeaningDataModel(meaningNum: 4, meaning: "To explore a place"),
            WordMeaningDataModel(meaningNum: 5, meaning: "To cook a meal"),
            WordMeaningDataModel(meaningNum: 6, meaning: "To write a letter"),
            WordMeaningDataModel(meaningNum: 7, meaning: "To solve a problem"),
            WordMeaningDataModel(meaningNum: 8, meaning: "To play a sport"),
            WordMeaningDataModel(meaningNum: 9, meaning: "To listen to music"),
            WordMeaningDataModel(meaningNum: 10, meaning: "To watch a movie")
        ]
    }
}

