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
        CardDataModel.self,
        ReviewResultDataModel.self,
        TargetWordDataModel.self,
        WordMeaningDataModel.self,
        ExampleSentenceDataModel.self,
        IllustrationDataModel.self,
        QuizDataModel.self
        
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    
    do {
        let container = try ModelContainer(for: CardDataModel.self,
                                           ReviewResultDataModel.self,
                                           TargetWordDataModel.self,
                                           WordMeaningDataModel.self,
                                           ExampleSentenceDataModel.self,
                                           IllustrationDataModel.self,
                                           QuizDataModel.self, configurations: modelConfiguration)

        
        let quizDataModels: [QuizDataModel] = QuizDataModel.samples
        let wordMeaningDataModels: [WordMeaningDataModel] = WordMeaningDataModel.samples
        let targetWordDataModels: [TargetWordDataModel] = TargetWordDataModel.samples
        let exampleSentenceDataModels: [ExampleSentenceDataModel] = ExampleSentenceDataModel.samples
        let illustrationDataModels: [IllustrationDataModel] = IllustrationDataModel.samples

        for q in quizDataModels {
            container.mainContext.insert(q)
        }
        for wm in wordMeaningDataModels {
            container.mainContext.insert(wm)
        }
        for tw in targetWordDataModels {
            container.mainContext.insert(tw)
        }
        for es in exampleSentenceDataModels {
            container.mainContext.insert(es)
        }
        for ill in illustrationDataModels {
            container.mainContext.insert(ill)
        }
        
        for targetWordDataModel in targetWordDataModels {
            for wordMeaningDataModel in wordMeaningDataModels {
                for exampleSentenceDataModel in exampleSentenceDataModels {
                    for illustrationDataModel in illustrationDataModels {
                        exampleSentenceDataModel.illustrations.append(illustrationDataModel)
                    }
                    wordMeaningDataModel.exampleSentences.append(exampleSentenceDataModel)
                }
                targetWordDataModel.wordMeaningDataModels.append(wordMeaningDataModel)
            }
        }
        
        for targetWordDataModel in targetWordDataModels {
            for quizDataModel in quizDataModels {
                targetWordDataModel.quizzes.append(quizDataModel)
            }
        }
        
        
        /// UserData
        var cardDataModels: [CardDataModel] = []
        
        for targetWordDataModel in targetWordDataModels {
            let currentCardDataModel = CardDataModel()
            container.mainContext.insert(currentCardDataModel)
            currentCardDataModel.targetWordDataModel = targetWordDataModel
            cardDataModels.append(currentCardDataModel)
        }
        
        for cardDataModel in cardDataModels {
            for _ in 0...3 {
                let currentReviewResult = ReviewResultDataModel.makeSample()
                container.mainContext.insert(currentReviewResult)
                cardDataModel.reviewResults.append(currentReviewResult)
            }
        }
        
        
        
        
        
        
        return container
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}
