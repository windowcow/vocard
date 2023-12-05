//
//  ExampleSentenceDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftData

@Model final class ExampleData {
    var id: UUID
    var sentence: String
    var sentenceInOtherLanguage: [String:String]
    
    @Relationship var illustrations: [IllustrationData]
    @Relationship(inverse: \MeaningData.exampleSentences) var meaningData: MeaningData?
    
    init(id: UUID = UUID(), sentence: String, sentenceInOtherLanguage: [String : String] = [:], illustrations: [IllustrationData] = []) {
        self.id = id
        self.sentence = sentence
        self.sentenceInOtherLanguage = sentenceInOtherLanguage
        self.illustrations = illustrations
    }
}

extension ExampleData {
    static var samples: [ExampleData] {
        [
            ExampleData(sentence: "To go somewhere"),
            ExampleData(sentence: "The cat sat on the mat"),
            ExampleData(sentence: "Swift programming is fun and interactive"),
            ExampleData(sentence: "The sun rises in the east"),
            ExampleData(sentence: "She loves reading books in her free time"),
            ExampleData(sentence: "Learning new languages opens up a world of opportunities"),
            ExampleData(sentence: "He is planning to travel to Japan next year"),
            ExampleData(sentence: "Artificial intelligence is transforming industries"),
            ExampleData(sentence: "Eating a balanced diet is essential for good health"),
            ExampleData(sentence: "Music brings people together")
        ]
    }
}


