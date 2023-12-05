//
//  WordMeaningDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftData

@Model final class MeaningDataModel {
    var id: UUID
    var meaningNum: Int
    var meaning: String
    var meaningInOtherLanguages: [String:String]
    var exampleSentences: [ExampleDataModel]
    
    init(id: UUID = UUID(), meaningNum: Int, meaning: String, meaningInOtherLanguages: [String : String] = [:], exampleSentences: [ExampleDataModel] = []) {
        self.id = id
        self.meaningNum = meaningNum
        self.meaning = meaning
        self.meaningInOtherLanguages = meaningInOtherLanguages
        self.exampleSentences = exampleSentences
    }
}

extension MeaningDataModel {
    static var samples: [MeaningDataModel] {
        [
            MeaningDataModel(meaningNum: 1, meaning: "To meet a friend"),
            MeaningDataModel(meaningNum: 2, meaning: "To engage in a hobby"),
            MeaningDataModel(meaningNum: 3, meaning: "To learn something new"),
            MeaningDataModel(meaningNum: 4, meaning: "To explore a place"),
            MeaningDataModel(meaningNum: 5, meaning: "To cook a meal"),
            MeaningDataModel(meaningNum: 6, meaning: "To write a letter"),
            MeaningDataModel(meaningNum: 7, meaning: "To solve a problem"),
            MeaningDataModel(meaningNum: 8, meaning: "To play a sport"),
            MeaningDataModel(meaningNum: 9, meaning: "To listen to music"),
            MeaningDataModel(meaningNum: 10, meaning: "To watch a movie")
        ]
    }
}

