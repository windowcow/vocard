//
//  CardFrontView.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI

enum CardDirection {
    case left
    case right
}

struct CardDragSettings {
    static let cardMenuOffsetCriterion: CGFloat = 90

    // 카드가 왼쪽에 있는지 판단하는 범위
    static var cardAtLeftRange: Range<CGFloat> {
        -CGFloat.infinity..<(-cardMenuOffsetCriterion)
    }

    // 카드가 오른쪽에 있는지 판단하는 범위
    static var cardAtRightRange: Range<CGFloat> {
        cardMenuOffsetCriterion..<CGFloat.infinity
    }

    // 추가적으로 중간 범위도 정의할 수 있습니다
    static var cardAtCenterRange: Range<CGFloat> {
        // 중간 범위를 정의하는 로직 (예시)
        -cardMenuOffsetCriterion..<cardMenuOffsetCriterion
    }
}


struct ReflectedAboutY: ViewModifier {
    func body(content: Content) -> some View {
        content
            .visualEffect { content, _ in
                    content
                        .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
            }
    }
}

extension View {
    func reflectedAboutY() -> some View {
        self.modifier(ReflectedAboutY())
    }
}


//#Preview {
//    ZStack {
//        CardFrontView(cardData: .example1)
//            .cardDragModifier(cardSide: Binding<CardSide>.constant(CardSide.front))
//    }
//}
