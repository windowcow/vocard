//
//  WordMeaningDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftData

@Model final class MeaningData {
    @Relationship var wordData: WordData?
    @Relationship(inverse: \ExampleData.meaningData) var exampleSentences: [ExampleData] = []

    var meaningNum: Int
    var meaning: String
    var meaningInOtherLanguages: [String:String]
    
    
    init(exampleSentences: [ExampleData] = [], meaningNum: Int, meaning: String, meaningInOtherLanguages: [String : String] = [:]) {
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

