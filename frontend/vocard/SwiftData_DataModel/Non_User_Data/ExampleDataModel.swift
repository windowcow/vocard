//
//  ExampleSentenceDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftData

@Model final class ExampleDataModel {
    var id: UUID
    var sentence: String
    var sentenceInOtherLanguage: [String:String]
    var illustrations: [IllustrationDataModel]
    
    init(id: UUID = UUID(), sentence: String, sentenceInOtherLanguage: [String : String] = [:], illustrations: [IllustrationDataModel] = []) {
        self.id = id
        self.sentence = sentence
        self.sentenceInOtherLanguage = sentenceInOtherLanguage
        self.illustrations = illustrations
    }
}

extension ExampleDataModel {
    static var samples: [ExampleDataModel] {
        [
            ExampleDataModel(sentence: "To go somewhere"),
            ExampleDataModel(sentence: "The cat sat on the mat"),
            ExampleDataModel(sentence: "Swift programming is fun and interactive"),
            ExampleDataModel(sentence: "The sun rises in the east"),
            ExampleDataModel(sentence: "She loves reading books in her free time"),
            ExampleDataModel(sentence: "Learning new languages opens up a world of opportunities"),
            ExampleDataModel(sentence: "He is planning to travel to Japan next year"),
            ExampleDataModel(sentence: "Artificial intelligence is transforming industries"),
            ExampleDataModel(sentence: "Eating a balanced diet is essential for good health"),
            ExampleDataModel(sentence: "Music brings people together")
        ]
    }
}


