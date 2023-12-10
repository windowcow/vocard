//
//  Array+CardDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation

extension Array where Element == CardData {
    @MainActor
    func getCard(unseenCardProb prob: Int = 30) -> Element? {
//        print(self.debugDescription)
        /// 본 것 중  복습 가능한 카드
        let seenReviewable = self.filter { card in
            !card.isUnseen && card.weight != nil
        }
        
        /// 안 본 카드 전부
        let unseenReviewable = self.filter { card in
            return card.isUnseen
        }
        
        if seenReviewable.isEmpty && unseenReviewable.isEmpty {
//            print("둘 다 빔")
            return nil
        } else if seenReviewable.isEmpty {
            return unseenReviewable.randomElement()!
        } else if unseenReviewable.isEmpty {
            return seenReviewable.filter {card in
                card.weight != nil
            }.sorted { card1, card2 in
                card1.weight! > card2.weight!
            }.first!
        } else {
            /// 둘 카드가 1장 이상 있는 경우
            let isSeenCardSelected = [true, false].pickOneByProbabilityOf(100 - prob) ?? true
            if isSeenCardSelected {
                return seenReviewable.pickOne()!
            } else {
                return unseenReviewable.randomElement()!
            }
        }
    }
    @MainActor
    var cardsWithWeights: [(Element, Double)] {
        if isEmpty { return [] }
        return self.compactMap { card in
            if let weight = card.weight {
                return (card, weight)
            } else {
                return nil
            }
        }
    }
    @MainActor
    var weightSum: Double {
        return cardsWithWeights.reduce(0){$0 + $1.1}
    }
    @MainActor
    var cardsWithProbability: [(Element, Double)] {
        guard weightSum != 0 else  { return cardsWithWeights}
        return cardsWithWeights.map{ ($0, $1 / weightSum) }
    }
    @MainActor
    func pickOne() -> Element? {
        guard !isEmpty else { return nil }

        let totalWeight = weightSum

        guard totalWeight > 0 else { return nil }

        let randomNumber = Double.random(in: 0..<totalWeight)

        var weightSum = 0.0
        for element in self {
            if let weight = element.weight {
                weightSum += weight
                if randomNumber < weightSum {
                    return element
                }
            }
        }
        return self.first!
    }
}
