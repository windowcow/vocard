//
//  Deck.swift
//  vocard
//
//  Created by windowcow on 11/27/23.
//

import SwiftData

@Model final class Deck {
    var seenCardDeck: MaxHeap
    var unseenCardDeck: [WordDataModel]
    var currentCard: WordDataModel?
    
    // 앱 처음 실행 때 생성된다
    init(seenCardDeck: MaxHeap, unseenCardDeck: [WordDataModel]) {
        self.seenCardDeck = seenCardDeck
        self.unseenCardDeck = unseenCardDeck
    }
    
    func changeCurrentCard(_ isCurrentCardReviewSuccess: Bool) {
        // 이전 카드 다루기
        if let currentCard = self.currentCard {
            if isCurrentCardReviewSuccess {
                currentCard.reviewSuccess()
                seenCardDeck.insert(currentCard)
            } else {
                currentCard.reviewFail()
                seenCardDeck.insert(currentCard)
            }
        }
        self.currentCard = nil

        
        // 새로운 카드 뽑기
        let res: Bool = [true, false].randomElement()!
        
        if seenCardDeck.isEmpty && unseenCardDeck.isEmpty {
            self.currentCard = nil
        } else if seenCardDeck.isEmpty {
            self.currentCard = unseenCardDeck.removeLast()
        } else if unseenCardDeck.isEmpty {
            self.currentCard = seenCardDeck.pop()!
        } else {
            self.currentCard = res ? seenCardDeck.pop()! : unseenCardDeck.removeLast()
        }
        
    }
    
    
}


