//
//  WordMeaningDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftData

@Model final class MeaningData {
    var id: UUID
    var meaningNum: Int
    var meaning: String
    var meaningInOtherLanguages: [String:String]
    
    @Relationship var exampleSentences: [ExampleData]
    @Relationship(inverse: \WordData.wordMeaningDataModels) var wordData: WordData?
    
    init(id: UUID = UUID(), meaningNum: Int, meaning: String, meaningInOtherLanguages: [String : String] = [:], exampleSentences: [ExampleData] = []) {
        self.id = id
        self.meaningNum = meaningNum
        self.meaning = meaning
        self.meaningInOtherLanguages = meaningInOtherLanguages
        self.exampleSentences = exampleSentences
    }
}

extension MeaningData {
    static var samples: [MeaningData] {
        [
            MeaningData(meaningNum: 1, meaning: "To meet a friend"),
            MeaningData(meaningNum: 2, meaning: "To engage in a hobby"),
            MeaningData(meaningNum: 3, meaning: "To learn something new"),
            MeaningData(meaningNum: 4, meaning: "To explore a place"),
            MeaningData(meaningNum: 5, meaning: "To cook a meal"),
            MeaningData(meaningNum: 6, meaning: "To write a letter"),
            MeaningData(meaningNum: 7, meaning: "To solve a problem"),
            MeaningData(meaningNum: 8, meaning: "To play a sport"),
            MeaningData(meaningNum: 9, meaning: "To listen to music"),
            MeaningData(meaningNum: 10, meaning: "To watch a movie")
        ]
    }
}

