//
//  View-Extensions.swift
//  vocard
//
//  Created by windowcow on 11/11/23.
//

import SwiftUI

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

