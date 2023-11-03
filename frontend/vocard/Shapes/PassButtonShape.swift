//
//  PassButtonShape.swift
//  vocard
//
//  Created by windowcow on 10/31/23.
//

import SwiftUI

struct PassButtonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.31746*height))
        path.addCurve(to: CGPoint(x: 0.06061*width, y: 0), control1: CGPoint(x: 0, y: 0.14213*height), control2: CGPoint(x: 0.02713*width, y: 0))
        path.addLine(to: CGPoint(x: 0.93939*width, y: 0))
        path.addCurve(to: CGPoint(x: width, y: 0.31746*height), control1: CGPoint(x: 0.97287*width, y: 0), control2: CGPoint(x: width, y: 0.14213*height))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: 0.31746*height))
        path.closeSubpath()
        return path
    }
}
#Preview(body: {
    PassButtonShape()
        .frame(width: 200, height: 40)
})
