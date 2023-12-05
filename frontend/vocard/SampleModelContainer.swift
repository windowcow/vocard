//
//  SampleModelContainer.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//
import SwiftData

@MainActor
var sharedModelContainer: ModelContainer {
    
    let schema = Schema([
        CardData.self,
        ReviewData.self,
        WordData.self,
        MeaningData.self,
        ExampleData.self,
        IllustrationData.self,
        QuizData.self
        
    ])
    let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
    
    do {
        let container = try ModelContainer(for: schema, configurations: modelConfiguration)
        
        let quizData: [QuizData] = QuizData.samples
        let meaningData: [MeaningData] = MeaningData.samples
        let wordData: [WordData] = WordData.samples
        let exampleData: [ExampleData] = ExampleData.samples
        let illustrationData: [IllustrationData] = IllustrationData.samples

//        for q in quizData {
//            container.mainContext.insert(q)
//        }
        for wm in meaningData {
            container.mainContext.insert(wm)
        }
//        for tw in wordData {
//            container.mainContext.insert(tw)
//        }
        for es in exampleData {
            container.mainContext.insert(es)
        }
        for ill in illustrationData {
            container.mainContext.insert(ill)
        }
        
        for word in wordData {
            for meaning in meaningData {
                for example in exampleData {
                    for illustration in illustrationData {
                        example.illustrations.append(illustration)
                        illustration.exampleData = example
                    }
                    meaning.exampleSentences.append(example)
                    example.meaningData = meaning
                }
                word.wordMeaningDataModels.append(meaning)
                meaning.wordData = word
            }
        }
        
        for word in wordData {
            for quiz in quizData {
                word.quizzes.append(quiz)
                quiz.wordData = word
            }
        }
        
        
        /// UserData
        var cardDataModels: [CardData] = []
        
        for word in wordData {
            let currentCardDataModel = CardData()
            container.mainContext.insert(currentCardDataModel)
            currentCardDataModel.wordData = word
            cardDataModels.append(currentCardDataModel)
        }
        
        for cardDataModel in cardDataModels {
            for _ in 0...3 {
                let currentReviewResult = ReviewData.makeSample()
                container.mainContext.insert(currentReviewResult)
                cardDataModel.reviewData.append(currentReviewResult)
            }
        }
        
        
        
        
        
        
        return container
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}
