//
//  Array+CardDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation

extension Array where Element == CardData {
    func getCard(unseenCardProb prob: Int = 50) -> Element? {
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
            print("둘 다 빔")
            return nil
        } else if seenReviewable.isEmpty {
            return unseenReviewable.randomElement()!
        } else if unseenReviewable.isEmpty {
            return seenReviewable.sorted { card1, card2 in
                card1.weight! > card2.weight!
            }.first!
        } else {
            /// 둘 카드가 1장 이상 있는 경우
            let isSeenCardSelected = [true, false].pickOneByProbabilityOf(prob) ?? true
            if isSeenCardSelected {
                return seenReviewable.sorted { card1, card2 in
                    card1.weight! > card2.weight!
                }.first!
            } else {
                return unseenReviewable.randomElement()!
            }
        }
    }
}
