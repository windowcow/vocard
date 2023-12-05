//
//  CardStudyPage_Bottom.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/3/23.
//

import Foundation
import SwiftUI

struct CardStudyPage_Bottom: View {
    @Binding var cardViewStatus: CardViewStatus
    @Environment(CardDataModel.self) var currentCard: CardDataModel?
    
    var body: some View {
        switch cardViewStatus {
        case .front:
            EmptyView()
        case .detail:
            Button {
                if let currentCard = currentCard {
                    do {
                        try currentCard.reviewFailed()

                    } catch {
                        
                    }
                }
            } label: {
                Text("NEXT")
                    .frame(maxWidth: .infinity)
            }
        case .quiz:
            HStack {
                Button {
                    if let currentCard = currentCard {
                        do {
                            try currentCard.reviewFailed()

                        } catch {
                            
                        }
                    }
                } label: {
                    Text("PASS")
                        .frame(maxWidth: .infinity)
                }
                
                Button {
                    if let currentCard = currentCard {
                        do {
                            
                            try currentCard.reviewFailed()

                        } catch {
                            
                        }
                    }
                } label: {
                    Text("SUBMIT")
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}
