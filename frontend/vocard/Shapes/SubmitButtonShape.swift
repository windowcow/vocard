//
//  SubmitButtonShape.swift
//  vocard
//
//  Created by windowcow on 10/31/23.
//

import SwiftUI

struct SubmitButtonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.31746*height))
        path.addCurve(to: CGPoint(x: 0.1*width, y: 0), control1: CGPoint(x: 0, y: 0.14213*height), control2: CGPoint(x: 0.04477*width, y: 0))
        path.addLine(to: CGPoint(x: 0.9*width, y: 0))
        path.addCurve(to: CGPoint(x: width, y: 0.31746*height), control1: CGPoint(x: 0.95523*width, y: 0), control2: CGPoint(x: width, y: 0.14213*height))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: 0.31746*height))
        path.closeSubpath()
        return path
    }
}
